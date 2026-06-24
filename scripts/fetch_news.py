from __future__ import annotations
import os, re, json, sys, time, random
from datetime import datetime, timezone
from collections import Counter

import requests

_env_path = os.path.join(os.path.dirname(__file__), '.env')
if os.path.exists(_env_path):
    with open(_env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, _, val = line.partition('=')
                os.environ.setdefault(key.strip(), val.strip())

SUPABASE_URL = os.getenv("SUPABASE_URL", "https://qwxsntvobtfjldurswfq.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY", "")
WORLDNEWS_KEY = os.getenv("WORLDNEWS_API_KEY", "0b81722a904348f795a0a8f2bc093a5d")

CATEGORY_MAP = {
    "general": "general", "politics": "general", "world": "general",
    "sports": "sports", "sport": "sports",
    "technology": "technology", "tech": "technology", "science": "science",
    "business": "business", "finance": "business", "economy": "business",
    "entertainment": "entertainment", "culture": "entertainment",
    "music": "entertainment", "movies": "entertainment", "gaming": "entertainment",
    "health": "science", "environment": "science", "nature": "science",
}

LEVEL_PATTERNS = {
    "A1": [r"\b(is|am|are|have|has|do|does)\b", r"\b(hello|hi|good|bad|big|small)\b"],
    "A2": [r"\b(was|were|been|done|made|took|gave|went)\b", r"\b(because|but|so|then|also|very|quite|always|usually)\b"],
    "B1": [r"\b(although|however|therefore|meanwhile|nevertheless|furthermore)\b", r"\b(experience|important|different|possible|problem|situation|opportunity|decision)\b"],
    "B2": [r"\b(consequently|subsequently|alternatively|ultimately|inevitably|significantly)\b", r"\b(implement|establish|demonstrate|investigate|analyze|comprehensive|widespread|emerging)\b"],
    "C1": [r"\b(notwithstanding|nevertheless|hitherto|thereafter|aforementioned|paradigm|ubiquitous|unprecedented)\b"],
}

CEFR_WORD_TARGETS = {
    "A1": (50, 80), "A2": (80, 130), "B1": (130, 200), "B2": (200, 300), "C1": (300, 450),
}


def split_sentences(text: str) -> list[str]:
    raw = re.split(r"(?<=[.!?])\s+", text.strip())
    return [s.strip() for s in raw if s.strip()]


def truncate_to_word_count(sentences: list[str], lo: int, hi: int) -> str:
    result = []
    count = 0
    target = (lo + hi) // 2
    for s in sentences:
        wc = len(s.split())
        if count + wc > target and count >= lo:
            break
        result.append(s)
        count += wc
        if count >= target:
            break
    return " ".join(result)


def generate_level_text(text: str, level: str) -> str:
    if not text:
        return ""
    lo, hi = CEFR_WORD_TARGETS.get(level, (130, 200))
    sents = split_sentences(text)
    if not sents:
        return text[:hi * 6]
    return truncate_to_word_count(sents, lo, hi)


def generate_level_description(text: str, level: str) -> str:
    if not text:
        return ""
    target = {"A1": 25, "A2": 35, "B1": 50, "B2": 80, "C1": 120}.get(level, 50)
    sents = split_sentences(text)
    if not sents:
        return text[:target * 6]
    return truncate_to_word_count(sents, target // 2, target)


def estimate_level(text: str) -> str:
    words = text.split()
    if len(words) < 100:
        return "A1"
    sentences = len(re.split(r"[.!?]+", text))
    avg = len(words) / max(sentences, 1)
    scores = {level: sum(len(re.findall(p, text, re.I)) for p in pats)
              for level, pats in LEVEL_PATTERNS.items()}
    if avg > 25: scores["C1"] += 2
    elif avg > 20: scores["B2"] += 2
    elif avg > 15: scores["B1"] += 1
    for level in ["C1", "B2", "B1", "A2", "A1"]:
        if scores[level] > 0:
            return level
    return "A1"


def extract_vocabulary(text: str) -> list[dict]:
    words = re.findall(r"\b[a-zA-Z]{4,}\b", text.lower())
    stop = {"the", "this", "that", "with", "from", "have", "been",
            "they", "them", "their", "what", "when", "where",
            "than", "then", "also", "just", "about", "more", "some",
            "which", "while", "there", "after", "first", "would", "could",
            "should", "into", "over", "such", "very", "your", "will",
            "were", "been", "said", "says", "after", "before", "still",
            "because", "between", "through", "without", "within"}
    words = [w for w in words if w not in stop]
    freq = Counter(words)
    seen = set()
    vocab = []
    for w, _ in freq.most_common(15):
        if w in seen:
            continue
        seen.add(w)
        vocab.append({"word": w, "definition": "", "translation": "",
                       "synonyms": [], "example": "", "part_of_speech": ""})
    return vocab


def apply_highlights(text: str, vocab_words: list[str]) -> str:
    sorted_words = sorted(vocab_words, key=lambda w: -len(w))
    result = text
    for w in sorted_words:
        result = re.sub(
            r'\b' + re.escape(w) + r'\b',
            f'<highlight>{w}</highlight>',
            result,
            flags=re.IGNORECASE,
        )
    return result


def map_category(cat: str) -> str:
    return CATEGORY_MAP.get(cat.lower().strip(), "general")


def supabase_insert_article(article: dict) -> str | None:
    headers = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}",
               "Content-Type": "application/json"}
    try:
        payload = {f"p_{k}": v for k, v in article.items() if not k.startswith("_")}
        resp = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/insert_article",
            json=payload, headers=headers, timeout=15,
        )
        if resp.status_code == 200:
            return resp.text.strip().strip('"')
        print(f"  Insert error: {resp.status_code} {resp.text[:200]}")
        return None
    except Exception as e:
        print(f"  Insert exception: {e}")
        return None


def generate_quiz(title: str, content: str) -> list:
    random.seed(hash(title))
    sentences = []
    for s in content.replace("!", ".").replace("?", ".").split("."):
        s = s.strip()
        words = s.split()
        if 8 <= len(words) <= 30:
            sentences.append(s)
    sentences.sort(key=lambda s: len(s), reverse=True)
    sentences = sentences[:15]
    all_words = content.split()
    word_set = {
        w.lower().strip(".,!?\"'()[]") for w in all_words
        if len(w) > 3 and w.strip(".,!?\"'()[]")[0].isalpha()
    }

    questions = []
    for sentence in sentences:
        if len(questions) >= 5:
            break
        words = sentence.split()
        candidates = []
        for i, w in enumerate(words):
            clean = w.strip(".,!?\"'()[]")
            if len(clean) > 3 and i > 0 and i < len(words) - 1 and clean[0].isalpha():
                candidates.append((i, clean))
        if not candidates:
            continue
        idx, answer = random.choice(candidates)
        dl = [w for w in word_set if w != answer.lower()]
        if len(dl) < 3:
            continue
        distractors = random.sample(dl, 3)
        options = [answer] + distractors
        random.shuffle(options)
        correct_idx = options.index(answer)
        words[idx] = "______"
        question = " ".join(words)
        questions.append({
            "question": f"Complete the sentence: {question}",
            "options": options,
            "correctIndex": correct_idx,
        })
    return questions


def fetch_worldnewsapi(limit: int = 20) -> list[dict]:
    if not WORLDNEWS_KEY:
        return []
    categories = ["general", "sports", "technology", "business", "science", "entertainment"]
    all_articles = []
    per_cat = max(1, (limit + len(categories) - 1) // len(categories))
    for cat in categories:
        if len(all_articles) >= limit:
            break
        try:
            url = (
                f"https://api.worldnewsapi.com/search-news"
                f"?api-key={WORLDNEWS_KEY}"
                f"&text={cat}"
                f"&language=en"
                f"&source-countries=us,gb"
                f"&number={per_cat}"
                f"&sort=publish-time"
            )
            resp = requests.get(url, timeout=30)
            if resp.status_code != 200:
                continue
            data = resp.json()
            for r in data.get("news", []):
                r["_apiCategory"] = cat
                r["_apiSource"] = "worldnews"
                all_articles.append(r)
                if len(all_articles) >= limit:
                    return all_articles
        except Exception as e:
            print(f"  Worldnews error ({cat}): {e}")
            continue
    return all_articles


def process_article(r: dict, idx: int, total: int) -> dict | None:
    title = r["title"]
    full_text = r.get("text") or ""
    summary = (r.get("summary") or "")[:500]
    category = map_category(r.get("_apiCategory") or r.get("category") or "")
    source = r.get("author") or "WorldNewsAPI"
    published_at = r.get("publish_date") or datetime.now(timezone.utc).isoformat()

    if not full_text or len(full_text.split()) < 50:
        return None

    content_c1 = full_text
    levels = ["A1", "A2", "B1", "B2", "C1"]
    content_by_level = {lvl: generate_level_text(content_c1, lvl) for lvl in levels}
    desc_by_level = {lvl: generate_level_description(summary, lvl) for lvl in levels}

    base_level = estimate_level(content_c1)
    vocab = extract_vocabulary(content_c1)
    quiz_questions = generate_quiz(title, content_c1)
    if quiz_questions:
        vocab.insert(0, {"_type": "quiz", "questions": quiz_questions})

    vocab_words = [v["word"] for v in vocab if v.get("word") and v.get("_type") != "quiz"]
    for lvl in levels:
        content_by_level[lvl] = apply_highlights(content_by_level[lvl], vocab_words)

    qc = len(quiz_questions)
    print(f"  [{idx}/{total}] B1:{len(content_by_level['B1'].split())}w  quiz:{qc}")

    return {
        "title": title,
        "description": summary,
        "category": category,
        "source": str(source),
        "image_url": r.get("image") or "",
        "audio_url": "",
        "base_level": base_level,
        "published_at": published_at,
        "content_a1": content_by_level["A1"],
        "content_a2": content_by_level["A2"],
        "content_b1": content_by_level["B1"],
        "content_b2": content_by_level["B2"],
        "content_c1": content_by_level["C1"],
        "description_a1": desc_by_level["A1"],
        "description_a2": desc_by_level["A2"],
        "description_b1": desc_by_level["B1"],
        "description_b2": desc_by_level["B2"],
        "description_c1": desc_by_level["C1"],
        "vocabulary": vocab,
        "quiz": {"questions": quiz_questions},
    }


def main():
    print("=" * 60)
    print(f"NewsLingo News Fetcher — {datetime.now().isoformat()}")
    print("=" * 60)

    limit = 10
    i = 1
    while i < len(sys.argv):
        arg = sys.argv[i]
        if arg == "--limit" and i + 1 < len(sys.argv):
            i += 1
            limit = int(sys.argv[i])
        elif arg.isdigit():
            limit = int(arg)
        i += 1

    print("Mode: RAW (algorithmic only, no AI)")
    print(f"Limit: {limit} articles")

    print(f"\nFetching from Worldnewsapi...")
    articles_raw = fetch_worldnewsapi(limit)
    print(f"  Got {len(articles_raw)} articles")

    seen = set()
    deduped = []
    for r in articles_raw:
        key = (r.get("title") or "").lower().strip()
        if key in seen or not r.get("title"):
            continue
        text = r.get("text", "")
        if len(text.split()) < 50:
            continue
        seen.add(key)
        deduped.append(r)
    print(f"After dedup: {len(deduped)}")

    if not deduped:
        print("No articles to process.")
        return

    articles = []
    for i, r in enumerate(deduped, 1):
        art = process_article(r, i, len(deduped))
        if art:
            articles.append(art)

    inserted_count = 0
    for idx, art in enumerate(articles):
        wc = len(art["content_b1"].split())
        print(f"  [{idx+1}/{len(articles)}] {art['title'][:50]} ({wc}w B1)")
        art_id = supabase_insert_article(art)
        if not art_id:
            print(f"    SKIP (insert failed)")
            continue
        inserted_count += 1

    print()
    print(f"{'='*60}")
    print(f"Processed: {len(articles)} articles")
    print(f"Inserted: {inserted_count}/{len(articles)}")
    print(f"Daily limit used: ~{limit} / 50 available")
    print(f"{'='*60}")


if __name__ == "__main__":
    main()
