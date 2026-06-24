import { serve } from "https://deno.land/std@0.192.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.0"

const NEWS_API_KEY = Deno.env.get("NEWSDATA_API_KEY") || ""
const MEDIASTACK_KEY = Deno.env.get("MEDIASTACK_API_KEY") || ""
const DEEPL_KEY = Deno.env.get("DEEPL_API_KEY") || ""

const CATEGORY_MAP: Record<string, string> = {
  general: "general", politics: "general", world: "general",
  sports: "sports", sport: "sports",
  technology: "technology", tech: "technology", science: "science",
  business: "business", finance: "business", economy: "business",
  science: "science", environment: "science", nature: "science", health: "science",
  entertainment: "entertainment", culture: "entertainment", music: "entertainment",
  movies: "entertainment", film: "entertainment", gaming: "entertainment",
}

const LEVEL_KEYWORDS: Record<string, RegExp[]> = {
  A1: [/^(is|am|are|have|has|do|does)\b/i, /\b(hello|hi|good|bad|big|small|day|night|eat|drink|go|come|see|look)\b/i],
  A2: [/^(was|were|been|done|made|took|gave|went|came|saw)\b/i, /\b(because|but|so|then|also|very|quite|always|usually|often|sometimes|never)\b/i],
  B1: [/\b(although|however|therefore|meanwhile|nevertheless|furthermore|consequently)\b/i, /\b(experience|important|different|possible|problem|situation|opportunity|decision|opinion|suggestion)\b/i],
  B2: [/\b(consequently|subsequently|alternatively|ultimately|inevitably|significantly|substantially)\b/i, /\b(implement|establish|demonstrate|investigate|analyze|comprehensive|widespread|emerging)\b/i],
  C1: [/\b(notwithstanding|nevertheless|hitherto|thereafter|aforementioned|paradigm|ubiquitous|unprecedented|idiosyncratic)\b/i],
}

function estimateLevel(text: string): string {
  const words = text.split(/\s+/).length
  if (words < 100) return "A1"
  const sentences = text.split(/[.!?]+/).length
  const avgWordsPerSentence = words / Math.max(sentences, 1)
  const matches = { A1: 0, A2: 0, B1: 0, B2: 0, C1: 0 }
  for (const [level, patterns] of Object.entries(LEVEL_KEYWORDS)) {
    for (const p of patterns) {
      const m = text.match(p)
      if (m) matches[level as keyof typeof matches] += m.length
    }
  }
  if (avgWordsPerSentence > 25) matches.C1 += 2
  else if (avgWordsPerSentence > 20) matches.B2 += 2
  else if (avgWordsPerSentence > 15) matches.B1 += 1
  if (matches.C1 > 0) return "C1"
  if (matches.B2 > 0) return "B2"
  if (matches.B1 > 0) return "B1"
  if (matches.A2 > 0) return "A2"
  return "A1"
}

function mapCategory(input: string): string {
  const clean = input.toLowerCase().trim()
  return CATEGORY_MAP[clean] || "general"
}

function extractTags(text: string): string[] {
  const stopWords = new Set(["the", "a", "an", "is", "are", "was", "were", "it", "this", "that", "in", "on", "at", "to", "for", "of", "with", "by", "from", "and", "or", "but", "not", "be", "has", "have", "do", "does"])
  const words = text.toLowerCase().replace(/[^a-z\s]/g, "").split(/\s+/).filter(w => w.length > 4 && !stopWords.has(w))
  const freq: Record<string, number> = {}
  for (const w of words) freq[w] = (freq[w] || 0) + 1
  return Object.entries(freq).sort((a, b) => b[1] - a[1]).slice(0, 8).map(e => e[0])
}

async function translateToArabic(texts: string[]): Promise<string[]> {
  if (!DEEPL_KEY || texts.length === 0) return texts
  try {
    const params = new URLSearchParams()
    params.set("target_lang", "AR")
    params.set("source_lang", "EN")
    for (const t of texts) params.append("text", t)
    const res = await fetch("https://api-free.deepl.com/v2/translate", {
      method: "POST",
      headers: {
        "Authorization": `DeepL-Auth-Key ${DEEPL_KEY}`,
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: params,
    })
    if (!res.ok) return texts
    const data = await res.json()
    return data.translations.map((t: { text: string }) => t.text)
  } catch { return texts }
}

function extractVocabulary(content: string): Array<{ word: string; definition: string; translation: string; synonyms: string[]; examples: string[]; part_of_speech: string }> {
  const highlightRegex = /<highlight>(.*?)<\/highlight>/g
  const matches = [...content.matchAll(highlightRegex)]
  const seen = new Set<string>()
  const vocab: Array<{ word: string; definition: string; translation: string; synonyms: string[]; examples: string[]; part_of_speech: string }> = []
  for (const m of matches) {
    const word = m[1].toLowerCase().trim()
    if (seen.has(word) || word.includes(" ") || word.length < 3) continue
    seen.add(word)
    vocab.push({
      word,
      definition: "",
      translation: "",
      synonyms: [],
      examples: [],
      part_of_speech: "",
    })
  }
  return vocab
}

function wrapHighlightWords(content: string, vocabulary: Array<{ word: string }>): string {
  let result = content
  const sorted = [...vocabulary].sort((a, b) => b.word.length - a.word.length)
  for (const v of sorted) {
    const regex = new RegExp(`\\b(${v.word})\\b`, "gi")
    result = result.replace(regex, "<highlight>$1</highlight>")
  }
  return result
}

async function fetchNewsdataIO(limit: number): Promise<any[]> {
  if (!NEWS_API_KEY) return []
  const categories = ["general", "sports", "technology", "business", "science", "entertainment"]
  const all: any[] = []
  for (const cat of categories) {
    try {
      const url = `https://newsdata.io/api/1/latest?apikey=${NEWS_API_KEY}&category=${cat}&country=us,gb,ae,fr,de&language=en&size=10`
      const res = await fetch(url)
      if (!res.ok) continue
      const data = await res.json()
      if (data.results) {
        for (const r of data.results) {
          all.push({ ...r, _apiCategory: cat, _apiSource: "newsdata" })
          if (all.length >= limit) return all
        }
      }
    } catch { continue }
  }
  return all
}

async function fetchMediastack(limit: number): Promise<any[]> {
  if (!MEDIASTACK_KEY) return []
  const categories = ["general", "sports", "technology", "business", "science", "entertainment"]
  const all: any[] = []
  for (const cat of categories) {
    try {
      const url = `http://api.mediastack.com/v1/news?access_key=${MEDIASTACK_KEY}&categories=${cat}&countries=us,gb,ae,fr,de&languages=en&limit=10`
      const res = await fetch(url)
      if (!res.ok) continue
      const data = await res.json()
      if (data.data) {
        for (const r of data.data) {
          all.push({ ...r, _apiCategory: cat, _apiSource: "mediastack" })
          if (all.length >= limit) return all
        }
      }
    } catch { continue }
  }
  return all
}

serve(async (req) => {
  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL") || ""
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") || ""
    const supabase = createClient(supabaseUrl, supabaseServiceKey)

    const limit = 120
    console.log("Fetching news from APIs...")

    const [newsdataArticles, mediastackArticles] = await Promise.all([
      fetchNewsdataIO(limit),
      fetchMediastack(limit),
    ])

    let rawArticles = [...newsdataArticles, ...mediastackArticles]
    console.log(`Fetched ${rawArticles.length} raw articles`)

    const seen = new Set<string>()
    const deduped: any[] = []

    for (const r of rawArticles) {
      const key = (r.title || "").toLowerCase().trim()
      if (seen.has(key) || !r.title || !r.description) continue
      seen.add(key)
      deduped.push(r)
    }

    const allTitles = deduped.map(r => r.title)
    const allDescs = deduped.map(r => r.description?.substring(0, 500) || "")
    const translated = await translateToArabic([...allTitles, ...allDescs])
    const arTitles = translated.slice(0, allTitles.length)
    const arDescriptions = translated.slice(allTitles.length)

    let inserted = 0
    for (let i = 0; i < deduped.length; i++) {
      const r = deduped[i]
      const contentRaw = r.content || r.description || ""
      const vocab = extractVocabulary(contentRaw)
      const content = vocab.length > 0 ? contentRaw : wrapHighlightWords(contentRaw, extractVocabulary(contentRaw))
      const category = mapCategory(r._apiCategory || r.category || "")
      const level = estimateLevel(content)
      const tags = r.tags?.length ? r.tags : extractTags(content)
      const source = r.source?.name || r.source || r._apiSource || "NewsAPI"
      
      const article = {
        title: r.title,
        description: r.description?.substring(0, 500) || "",
        content: content.substring(0, 5000),
        category,
        source,
        image_url: r.image_url || r.image || "",
        audio_url: "",
        level,
        published_at: new Date(r.published_at || r.publishedAt || Date.now()).toISOString(),
        tags,
        vocabulary: JSON.stringify(vocab),
        quiz: "{}",
      }

      const { error } = await supabase.from("articles").upsert(article, {
        onConflict: "id",
        ignoreDuplicates: true,
      })
      if (!error) inserted++
    }

    return new Response(JSON.stringify({
      success: true,
      fetched: rawArticles.length,
      deduped: deduped.length,
      inserted,
      timestamp: new Date().toISOString(),
    }), { headers: { "Content-Type": "application/json" } })

  } catch (err) {
    console.error("Edge function error:", err)
    return new Response(JSON.stringify({ success: false, error: String(err) }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    })
  }
})
