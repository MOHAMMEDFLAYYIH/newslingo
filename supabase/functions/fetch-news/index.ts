import { serve } from "https://deno.land/std@0.192.0/http/server.ts"

const NEWS_KEY = Deno.env.get("NEWSDATA_API_KEY") || ""
const DEEPL_KEY = Deno.env.get("DEEPL_API_KEY") || ""
const SUPABASE_URL = Deno.env.get("SUPABASE_URL") || ""
const SUPABASE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") || ""

const CATEGORY_MAP: Record<string, string> = {
  general: "general", politics: "general", world: "general",
  sports: "sports", sport: "sports",
  technology: "technology", tech: "technology", science: "science",
  business: "business", finance: "business", economy: "business",
  science: "science", environment: "science", nature: "science", health: "science",
  entertainment: "entertainment", culture: "entertainment", music: "entertainment",
  movies: "entertainment", film: "entertainment", gaming: "entertainment",
}

const LPs: Record<string, RegExp[]> = {
  A1: [/^(is|am|are|have|has|do|does)\b/i, /\b(hello|hi|good|bad|big|small)\b/i],
  A2: [/^(was|were|been|done|made|took|gave|went)\b/i, /\b(because|but|so|then|also|very|quite|always|usually)\b/i],
  B1: [/\b(although|however|therefore|meanwhile|nevertheless|furthermore)\b/i, /\b(experience|important|different|possible|problem|situation|opportunity|decision)\b/i],
  B2: [/\b(consequently|subsequently|alternatively|ultimately|inevitably|significantly)\b/i, /\b(implement|establish|demonstrate|investigate|analyze|comprehensive|widespread|emerging)\b/i],
  C1: [/\b(notwithstanding|nevertheless|hitherto|thereafter|aforementioned|paradigm|ubiquitous|unprecedented)\b/i],
}

const CEFR_TARGETS: Record<string, [number, number]> = {
  A1: [50, 80], A2: [80, 130], B1: [130, 200], B2: [200, 300], C1: [300, 450],
}

function split(text: string): string[] {
  return text.trim().split(/(?<=[.!?])\s+/).map(s => s.trim()).filter(Boolean)
}

function truncate(sentences: string[], lo: number, hi: number): string {
  const target = Math.floor((lo + hi) / 2)
  let count = 0, result: string[] = []
  for (const s of sentences) {
    const wc = s.split(/\s+/).length
    if (count + wc > target && count >= lo) break
    result.push(s); count += wc
    if (count >= target) break
  }
  return result.join(" ")
}

function genLevelText(text: string, level: string): string {
  const [lo, hi] = CEFR_TARGETS[level] || [130, 200]
  const s = split(text)
  return s.length ? truncate(s, lo, hi) : text.slice(0, hi * 6)
}

function genLevelDesc(text: string, level: string): string {
  const target: Record<string, number> = { A1: 25, A2: 35, B1: 50, B2: 80, C1: 120 }
  const t = target[level] || 50
  const s = split(text)
  return s.length ? truncate(s, Math.floor(t / 2), t) : text.slice(0, t * 6)
}

function estimateLevel(text: string): string {
  const words = text.split(/\s+/).length
  if (words < 100) return "A1"
  const sentences = text.split(/[.!?]+/).length
  const avg = words / Math.max(sentences, 1)
  const scores: Record<string, number> = { A1: 0, A2: 0, B1: 0, B2: 0, C1: 0 }
  for (const [level, patterns] of Object.entries(LPs)) {
    for (const p of patterns) {
      const m = text.match(p)
      if (m) scores[level] += m.length
    }
  }
  if (avg > 25) scores.C1 += 2
  else if (avg > 20) scores.B2 += 2
  else if (avg > 15) scores.B1 += 1
  for (const l of ["C1", "B2", "B1", "A2", "A1"]) {
    if (scores[l] > 0) return l
  }
  return "A1"
}

function extractVocab(text: string): { word: string; definition: string; translation: string; synonyms: string[]; example: string; part_of_speech: string }[] {
  const stop = new Set(["the","this","that","with","from","have","been","they","them","their","what","when","where","than","then","also","just","about","more","some","which","while","there","after","first","would","could","should","into","over","such","very","your","will","were","said","says","because","between","through","without","within"])
  const words = text.toLowerCase().replace(/[^a-z\s]/g, "").split(/\s+/).filter(w => w.length > 4 && !stop.has(w))
  const freq: Record<string, number> = {}
  for (const w of words) freq[w] = (freq[w] || 0) + 1
  const sorted = Object.entries(freq).sort((a, b) => b[1] - a[1]).slice(0, 15).map(e => e[0])
  return sorted.map(w => ({ word: w, definition: "", translation: "", synonyms: [], example: "", part_of_speech: "" }))
}

function applyHighlights(text: string, vocabWords: string[]): string {
  let result = text
  for (const w of [...vocabWords].sort((a, b) => b.length - a.length)) {
    result = result.replace(new RegExp(`\\b${w}\\b`, "gi"), `<highlight>$&</highlight>`)
  }
  return result
}

function generateQuiz(title: string, content: string): { questions: { question: string; options: string[]; correctIndex: number }[] } {
  const seed = [...title].reduce((a, c) => a + c.charCodeAt(0), 0)
  const rand = () => { let x = seed!; return () => { x = (x * 1103515245 + 12345) & 0x7fffffff; return x / 0x7fffffff } }
  const rng = rand()

  const sentences = content.replace(/[!?]/g, ".").split(".").map(s => s.trim()).filter(s => { const w = s.split(/\s+/); return w.length >= 8 && w.length <= 30 })
  sentences.sort((a, b) => b.length - a.length)
  const candidates = sentences.slice(0, 15)
  const allWords = [...new Set(content.split(/\s+/).map(w => w.toLowerCase().replace(/[^a-z]/g, "")).filter(w => w.length > 3))]

  const questions: { question: string; options: string[]; correctIndex: number }[] = []
  for (const sentence of candidates) {
    if (questions.length >= 5) break
    const words = sentence.split(/\s+/)
    const picks: { idx: number; word: string }[] = []
    for (let i = 1; i < words.length - 1; i++) {
      const clean = words[i].replace(/[^a-zA-Z]/g, "")
      if (clean.length > 3) picks.push({ idx: i, word: clean })
    }
    if (picks.length === 0) continue
    const pick = picks[Math.floor(rng() * picks.length)]
    const answer = pick.word
    const others = allWords.filter(w => w !== answer.toLowerCase())
    if (others.length < 3) continue
    const dist = [...others].sort(() => rng() - 0.5).slice(0, 3)
    const options = [answer, ...dist].sort(() => rng() - 0.5)
    const correctIndex = options.indexOf(answer)
    words[pick.idx] = "______"
    questions.push({ question: `Complete the sentence: ${words.join(" ")}`, options, correctIndex })
  }
  return { questions }
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
      headers: { "Authorization": `DeepL-Auth-Key ${DEEPL_KEY}`, "Content-Type": "application/x-www-form-urlencoded" },
      body: params,
    })
    if (!res.ok) return texts
    const data = await res.json()
    return data.translations.map((t: { text: string }) => t.text)
  } catch { return texts }
}

async function fetchNewsdataIO(limit: number): Promise<any[]> {
  if (!NEWS_KEY) return []
  const categories = ["general", "sports", "technology", "business", "science", "entertainment"]
  const all: any[] = []
  for (const cat of categories) {
    if (all.length >= limit) break
    try {
      const url = `https://newsdata.io/api/1/latest?apikey=${NEWS_KEY}&category=${cat}&country=us,gb&language=en&size=10`
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

serve(async () => {
  try {
    const limit = 20
    console.log("Fetching news from NewsdataIO...")
    const raw = await fetchNewsdataIO(limit)
    if (raw.length === 0) {
      return new Response(JSON.stringify({ success: false, error: "No API keys configured or no articles returned" }), {
        headers: { "Content-Type": "application/json" },
      })
    }

    const seen = new Set<string>()
    const deduped: any[] = []
    for (const r of raw) {
      const key = (r.title || "").toLowerCase().trim()
      if (seen.has(key) || !r.title) continue
      seen.add(key)
      const text = r.content || r.description || ""
      if (text.split(/\s+/).length < 50) continue
      deduped.push(r)
    }

    const titles = deduped.map(r => r.title)
    const descs = deduped.map(r => (r.description || "").substring(0, 500))
    const translated = await translateToArabic([...titles, ...descs])
    const arTitles = translated.slice(0, titles.length)
    const arDescs = translated.slice(titles.length)

    const levels = ["A1", "A2", "B1", "B2", "C1"]
    let inserted = 0

    for (let i = 0; i < deduped.length; i++) {
      const r = deduped[i]
      const fullText = r.content || r.description || ""
      const summary = (r.description || "").substring(0, 500)
      const category = CATEGORY_MAP[r._apiCategory || r.category || ""] || "general"
      const baseLevel = estimateLevel(fullText)

      const contentByLevel: Record<string, string> = {}
      const descByLevel: Record<string, string> = {}
      for (const lvl of levels) {
        contentByLevel[lvl] = genLevelText(fullText, lvl)
        descByLevel[lvl] = genLevelDesc(summary, lvl)
      }

      const vocab = extractVocab(fullText)
      const quiz = generateQuiz(r.title, fullText)
      if (quiz.questions.length > 0) {
        vocab.unshift({ _type: "quiz", questions: quiz.questions } as any)
      }

      const vocabWords = vocab.filter(v => v.word && (v as any)._type !== "quiz").map(v => v.word)
      for (const lvl of levels) {
        contentByLevel[lvl] = applyHighlights(contentByLevel[lvl], vocabWords)
      }

      const payload: Record<string, any> = {
        p_title: r.title,
        p_description: summary,
        p_category: category,
        p_source: r.source?.name || r.source || r._apiSource || "NewsdataIO",
        p_image_url: r.image_url || r.image || "",
        p_audio_url: "",
        p_base_level: baseLevel,
        p_published_at: new Date(r.published_at || r.publishedAt || Date.now()).toISOString(),
        p_vocabulary: JSON.stringify(vocab),
        p_quiz: JSON.stringify(quiz),
      }
      for (const lvl of levels) {
        payload[`p_content_${lvl.toLowerCase()}`] = contentByLevel[lvl]
        payload[`p_description_${lvl.toLowerCase()}`] = descByLevel[lvl]
      }

      const headers = { "apikey": SUPABASE_KEY, "Authorization": `Bearer ${SUPABASE_KEY}`, "Content-Type": "application/json" }
      const res = await fetch(`${SUPABASE_URL}/rest/v1/rpc/insert_article`, {
        method: "POST", headers, body: JSON.stringify(payload),
      })
      if (res.ok) inserted++
    }

    return new Response(JSON.stringify({
      success: true, fetched: raw.length, deduped: deduped.length, inserted, timestamp: new Date().toISOString(),
    }), { headers: { "Content-Type": "application/json" } })
  } catch (err) {
    return new Response(JSON.stringify({ success: false, error: String(err) }), {
      status: 500, headers: { "Content-Type": "application/json" },
    })
  }
})
