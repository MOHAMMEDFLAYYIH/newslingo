import { serve } from "https://deno.land/std@0.192.0/http/server.ts"

const FREE_DICT_API = "https://api.dictionaryapi.dev/api/v2/entries/en"

const ABBREVIATIONS = new Set([
  "mr", "mrs", "ms", "dr", "prof", "sr", "jr", "st", "dept", "est",
  "a.m", "p.m", "jan", "feb", "mar", "apr", "jun", "jul",
  "aug", "sep", "oct", "nov", "dec",
  "vs", "etc", "i.e", "e.g", "inc", "ltd", "corp",
  "govt", "approx", "avg", "max", "min",
  "u.s", "u.k", "e.u", "u.n",
])

function splitSentences(text: string): string[] {
  const abbreviations = Array.from(ABBREVIATIONS).join("|")
  const pattern = new RegExp(
    `(?<!\\b(?:${abbreviations})\\.)(?<=\\.|\\!|\\?)(?:\\s+|$)`,
    "gi"
  )
  const parts = text.trim().split(pattern).map(s => s.trim()).filter(Boolean)
  return parts.length ? parts : [text.trim()]
}

function cleanText(text: string): string {
  return text
    .replace(/<[^>]*>/g, "")
    .replace(/[\[\](){}]/g, "")
    .replace(/\s+/g, " ")
    .trim()
}

function wordTokens(text: string): string[] {
  return text
    .toLowerCase()
    .replace(/[^\w\s'-]/g, " ")
    .split(/\s+/)
    .filter(w => w.length > 0 && /[a-zA-Z]/.test(w))
}

const STOP_WORDS = new Set([
  "a", "an", "the", "and", "or", "but", "if", "when", "as", "at",
  "by", "for", "in", "of", "on", "to", "with", "into", "upon",
  "is", "are", "was", "were", "be", "been", "being", "am",
  "have", "has", "had", "do", "does", "did", "will", "would",
  "shall", "should", "may", "might", "can", "could", "must",
  "it", "its", "this", "that", "these", "those",
  "from", "about", "like", "just", "not", "no", "nor",
  "so", "very", "too", "also", "up", "down", "out", "off",
  "over", "under", "again", "further", "then", "once",
  "every", "all", "both", "each", "few",
  "more", "most", "other", "some", "such", "only", "own",
  "same", "than", "what", "which", "who", "why", "how", "where",
  "after", "before", "between", "through", "during",
  "because", "since", "until", "although", "though",
  "yet", "any", "anything", "anyone", "everything",
  "everyone", "nothing", "nobody", "something", "someone",
  "one", "two", "three", "first", "last", "next", "new",
  "old", "well", "back", "still", "even", "much", "many",
  "another", "per", "ago", "ever", "never", "now",
  "here", "there", "always", "often", "sometimes", "usually",
  "already", "around", "away",
])

const CEFR_A1 = new Set([
  "hello", "goodbye", "please", "thank", "sorry", "yes", "no",
  "big", "small", "hot", "cold", "new", "old", "good", "bad",
  "beautiful", "happy", "sad", "hungry", "thirsty", "tired",
  "water", "food", "house", "book", "school", "family", "friend",
  "name", "number", "color", "day", "week", "month", "year",
  "morning", "evening", "night", "today", "tomorrow", "yesterday",
  "eat", "drink", "sleep", "read", "write", "speak", "listen",
  "go", "come", "see", "want", "like", "love", "have", "live",
  "work", "study", "play", "walk", "run", "buy", "pay",
  "man", "woman", "child", "people", "country", "world",
  "weather", "sun", "rain", "snow", "wind",
  "always", "never", "often", "sometimes",
  "because", "but", "so", "then", "also", "very",
  "help", "open", "close", "sit", "stand", "tell",
  "give", "take", "make", "know", "think",
  "here", "there", "where", "what", "when",
])

const CEFR_A2 = new Set([
  "accident", "adult", "advice", "airport", "animal", "answer",
  "apartment", "appointment", "arrive", "artist", "beach", "begin",
  "belong", "better", "bicycle", "board", "borrow",
  "bridge", "busy", "camera", "cancel", "captain", "career",
  "celebrate", "century", "certain", "change", "cheap", "check",
  "choice", "choose", "church", "citizen", "city", "clean",
  "clever", "climb", "college", "comfortable",
  "compare", "competition", "complete", "computer", "concert",
  "condition", "conference", "control",
  "conversation", "correct", "cost", "couple", "course",
  "cousin", "create", "crime", "cross", "crowd",
  "culture", "customer",
  "damage", "dangerous", "daughter", "dead", "decide",
  "deliver", "describe", "desert", "destroy",
  "develop", "dictionary", "difference", "difficult", "dinner",
  "direction", "director", "discover", "discuss", "disease",
  "distance", "double", "doubt",
  "downtown", "dream",
  "driving", "during", "duty",
  "economy", "educate", "election", "electric",
  "employee", "empty", "encourage", "enemy", "engine",
  "enjoy", "enough", "entrance",
  "environment", "equipment", "escape", "especially",
  "examine", "example", "excellent", "except", "excited",
  "exercise", "exhibition", "exist", "expect", "expensive",
  "experience", "experiment", "expert", "explain", "explore",
  "extra", "extremely", "factory", "familiar",
  "famous", "fashion", "favourite", "female", "fence",
  "festival", "fever", "figure",
  "finance", "finger", "finish", "fire",
  "flight", "flood", "floor", "follow", "foreign", "forest",
  "forgive", "former", "forward", "freeze",
  "frequent", "friendly", "fruit",
  "funny", "furniture",
  "garden", "gate", "general", "generous", "gentle",
  "gesture", "glad", "glass",
  "goal", "golden",
  "government", "grandfather", "grandmother",
  "grateful", "great",
  "guest", "guide", "guilty",
  "habit", "handle", "happen",
  "happiness", "harm", "hate", "healthy",
  "height", "helpful", "hero", "hide",
  "hill", "history", "hobby", "honest",
  "hope", "however", "huge", "human",
  "husband",
  "identify", "ignore", "illness", "imagine", "immediate",
  "important", "impossible", "improve", "include", "increase",
  "indicate", "industry", "information",
  "inside", "instead", "instrument", "insurance", "intelligent",
  "intend", "interest", "international", "interrupt",
  "introduce", "invent", "invite", "involve", "island",
  "jealous", "journey", "judge",
  "keen", "kitchen", "knowledge",
  "lack", "language",
  "lawyer", "lazy", "leader", "legal",
  "leisure", "lend", "length", "level", "librarian",
  "lifestyle", "lift", "likely", "limit",
  "literature", "local", "lock", "lonely",
  "loss", "lovely", "lower",
  "luck", "luxury", "machine",
  "magazine", "magic", "main", "mainly", "manage",
  "manner", "marriage", "master", "material",
  "matter", "meaning", "meanwhile", "measure", "medicine",
  "medium", "member", "memory", "mental", "mention",
  "menu", "message", "metal", "method",
  "million", "mind", "minister", "minor",
  "mirror", "mistake",
  "model", "modern", "moment",
  "mood", "moral",
  "mostly", "motor", "mountain",
  "museum", "musical", "mysterious", "narrow", "nation",
  "native", "natural", "nature",
  "necessary", "negative", "neighbour", "neither",
  "nervous", "network",
  "nobody", "noise", "none", "normal",
  "northern", "notice",
  "nowadays", "nowhere",
  "obey", "object", "obtain", "obvious", "occasion",
  "offer", "officer", "official",
  "operation", "opinion", "opponent", "opportunity",
  "opposite", "ordinary", "organise", "origin", "otherwise",
  "ought", "outcome", "outside", "overcome", "owe",
  "owner",
  "painting", "parent", "particular", "partly",
  "partner", "passage", "passenger", "passport",
  "path", "patience", "patient", "pattern", "peace",
  "perform", "perhaps", "period", "permit", "person",
  "persuade", "phone", "photograph", "phrase",
  "physical", "pilot",
  "plan", "platform", "player", "pleasure", "plenty",
  "pocket", "poem", "poetry", "poison", "police", "polite",
  "political", "popular", "population", "port",
  "position", "positive", "possess",
  "possibility", "potato", "potential", "pound",
  "poverty", "powerful", "practical",
  "praise", "pray", "precious", "predict", "prefer",
  "preparation", "presence",
  "president", "pressure",
  "prevent", "previous", "pride",
  "primary", "prince", "princess", "principal", "principle", "print",
  "prison", "prisoner", "private", "prize", "probably",
  "produce", "professional", "profit",
  "programme", "progress", "project", "promise", "promote",
  "pronounce", "proof", "proper", "property", "propose",
  "protect", "protest", "proud", "prove",
  "provide", "public", "publish",
  "punish", "pupil", "purchase", "pure", "purpose", "pursue",
  "quality", "quantity", "quarter", "queen",
  "quick", "quiet", "quit", "quite",
  "race", "raise", "range", "rank",
  "rapid", "rare", "rate", "rather", "reach", "react",
  "reality", "realize", "reasonable", "receive", "recent",
  "recognize", "recommend", "record", "recover", "reduce",
  "refer", "reflect", "refuse", "regard", "region",
  "register", "regret", "regular", "reject", "relate",
  "relation", "relative", "release", "relief", "rely",
  "remain", "remember", "remind", "remote", "remove",
  "rent", "repair", "repeat", "replace", "reply",
  "represent", "republic", "reputation", "request",
  "resemble", "reserve", "resident", "resist", "resolve",
  "resource", "respect", "respond", "responsible",
  "restore", "restrict", "retire", "reveal",
  "review", "revolution", "reward",
  "risk", "ritual", "rival",
  "rough", "royal",
  "ruin", "ruler", "rural",
  "sacred", "sacrifice",
  "safe", "sail", "salary", "sale", "salt",
  "sample", "sand", "satisfy", "save",
  "scale", "scene", "schedule", "scheme",
  "science", "scientific", "score", "screen", "search",
  "season", "secret", "secretary", "section", "secure",
  "seed", "seek", "select",
  "sense", "sentence", "separate", "sequence", "series", "serious",
  "serve", "session", "settle", "several", "severe",
  "shadow", "shame", "shape", "share", "sharp",
  "shelf", "shelter", "shift", "shine",
  "shock", "shoot", "shore",
  "shoulder", "shout",
  "sight", "sign", "signal", "significant", "silence",
  "silver", "similar", "simple", "since", "sincere",
  "single", "situation", "skill", "skin",
  "slave", "slide", "slight",
  "smell", "smile", "smoke", "smooth",
  "social", "soil", "soldier", "solid",
  "solution", "sort", "soul", "source",
  "southern", "space", "spare", "speech", "speed",
  "spell", "spend", "spirit", "split",
  "spread", "square", "stable", "staff", "stage",
  "stamp", "standard", "stare", "state", "station",
  "status", "steady", "steal", "steel", "steep",
  "step", "stick", "stiff", "stir",
  "stomach", "stone", "store", "storm", "strange",
  "stranger", "stream", "strength", "stress", "stretch",
  "strict", "strike", "string", "stroke", "strong",
  "structure", "struggle", "studio", "stuff",
  "style", "subject", "submit", "substance",
  "succeed", "success", "suffer", "sugar", "suggest",
  "suit", "suitable", "sum", "summary", "summer",
  "supply", "support", "suppose", "sure",
  "surface", "surgery", "surprise", "surround", "survey",
  "survive", "suspect",
  "sweet", "swim", "swing", "switch",
  "symbol", "sympathy", "system",
  "tale", "talent", "tap", "tape", "target", "task",
  "taste", "tax", "teach", "team",
  "telephone", "television", "temper", "temple", "temporary", "tend",
  "tennis", "tent", "term", "terrible",
  "territory", "terror", "test", "text", "therefore",
  "thick", "thief", "thin",
  "though", "thousand", "threat", "throat",
  "throughout", "throw", "thumb", "ticket", "tidy",
  "tight", "tiny", "tip", "tire",
  "title", "tongue", "tool", "tooth", "top",
  "total", "touch", "tough", "tour", "toward", "towel",
  "tower", "track", "trade", "traditional", "traffic",
  "train", "transfer", "transform", "translate",
  "transport", "trap", "travel", "treasure", "treat",
  "treatment", "trend", "trial", "tribe",
  "trick", "trip", "trouble",
  "truck", "trust", "truth",
  "tune", "turn", "twice", "type", "typical",
  "ugly", "uncle", "underground",
  "understand", "unemployed", "unexpected", "uniform",
  "union", "unique", "unit", "universe",
  "unless", "unlikely", "unpleasant",
  "unusual", "upset", "upper",
  "urban", "urge",
  "useful", "useless", "user", "usual",
  "valley", "valuable", "value",
  "variety", "various", "vast", "vehicle", "version", "victim",
  "victory", "video", "view", "village", "violence",
  "virtue", "vision", "visit", "voice", "volume",
  "wage", "wait", "warn", "wave", "weak",
  "wealth", "weapon", "weather", "wedding", "weight",
  "welcome", "western", "wheel",
  "whether", "whisper", "whole",
  "wife", "wild",
  "willing", "win", "wine", "wing", "winner",
  "wipe", "wire", "wise", "wish", "witness", "wonder",
  "wooden", "worried", "worry", "worse", "worship",
  "worst", "worth", "worthy", "wound",
  "youth",
])

const CEFR_B1 = new Set([
  "absorb", "abstract", "abuse", "academic",
  "accelerate", "access", "accompany", "accomplish",
  "account", "accurate", "accuse", "achieve", "acknowledge",
  "acquire", "adapt", "adequate", "adjust", "administration",
  "admire", "admission", "adopt", "advance", "advantage",
  "advertise", "affair", "affect", "afford", "agency",
  "aggressive", "agree", "agriculture",
  "allocate", "allow", "alternative", "amaze",
  "ambition", "analyse", "ancestor",
  "announce", "annual", "anticipate", "anxiety",
  "apparent", "appeal", "appetite", "applicant",
  "application", "appoint", "appreciate", "approach",
  "appropriate", "approve", "argument", "arise",
  "arrangement", "artificial", "assemble", "assess",
  "asset", "assign", "assist", "associate", "assume",
  "assure", "atmosphere", "attach", "attempt", "attend",
  "attitude", "attract", "attribute", "audience",
  "authority", "automatic", "available", "average",
  "avoid", "award", "aware", "balance", "barrier",
  "basis", "behave", "beneath", "benefit",
  "blame", "blank", "blend",
  "block", "bold", "bond", "boost",
  "border", "bother", "boundary", "brave",
  "breed", "brief", "brilliant", "broad", "broadcast",
  "budget", "burden",
  "cabinet", "calculate", "campaign", "capable",
  "capacity", "capture", "carbon", "career", "cargo",
  "casual", "category", "cause",
  "challenge", "champion", "channel", "chapter",
  "character", "charge", "charity", "charm", "chart",
  "chemical", "circumstance", "civil",
  "claim", "clarify", "classic", "classify", "climate",
  "code", "collapse", "colleague",
  "combat", "combine", "command", "comment", "commerce",
  "commission", "commit", "commodity", "communicate",
  "community", "companion", "company",
  "compel", "compensate", "compete", "compile",
  "complain", "complement", "complex", "complicate",
  "component", "compose", "compound", "comprise",
  "compromise", "concentrate", "concept", "concern",
  "conclude", "concrete", "condemn", "conduct",
  "confess", "confident", "confine", "confirm",
  "conflict", "confront", "confuse", "connect",
  "conscious", "consequence", "conservative",
  "consider", "consist", "consistent", "constant",
  "constitutional", "construct", "consult", "consume",
  "contact", "contain", "contemporary", "contend",
  "contest", "context", "contract", "contrast",
  "contribute", "controversy", "convenient", "convention",
  "convince", "cooperate", "coordinate", "cope",
  "core", "corporate",
  "council", "counsel",
  "courage", "creative", "credibility",
  "credit", "crew", "criminal", "crisis", "criteria",
  "critic", "crucial", "cultivate", "curious", "current",
  "custom", "cycle",
  "debate", "debt", "decade", "decent", "declare",
  "decline", "decrease", "dedicate", "default", "defeat",
  "defend", "define", "defy", "delay", "delegate",
  "deliberate", "delicate", "demand", "democracy",
  "demonstrate", "deny", "depart", "depend", "depict",
  "deposit", "depress", "derive", "descend", "deserve",
  "design", "designate", "desperate", "despite",
  "destination", "destiny", "destroy", "detect",
  "determine", "develop", "device", "devote", "diagnose",
  "dialogue", "diet", "differ", "digest", "digital",
  "dignity", "dilemma", "dimension",
  "direct", "disagree", "disappear", "disaster",
  "discipline", "disclose", "discount",
  "dismiss", "disorder",
  "display", "disposal", "dispute",
  "distinct", "distinguish", "distort", "distract",
  "distress", "distribute", "district", "diverse",
  "document", "domestic", "dominant", "dominate",
  "donate", "draft", "drain", "dramatic", "drastic",
  "dynamic", "eager", "earn",
  "ecology", "economics",
  "edition", "editor", "effect", "efficient",
  "effort", "elaborate",
  "elderly", "elect",
  "element", "eliminate", "elsewhere", "embrace",
  "emerge", "emission", "emotion", "emphasis", "empire",
  "employ", "enable", "enclose", "encounter", "endorse",
  "endure", "enforce", "engage", "enhance",
  "enormous", "ensure", "enterprise", "entertain",
  "enthusiasm", "entire", "entitle", "entry",
  "episode", "equal", "equip", "equivalent", "era",
  "error", "erupt", "establish", "estate", "estimate",
  "evaluate", "evident", "evil", "evolve", "exact",
  "examine", "exceed", "exception", "excess", "exchange",
  "excite", "exclude", "execute", "exempt", "exert",
  "exhaust", "exhibit", "expand", "expense",
  "exploit", "export", "expose", "express", "extend",
  "extensive", "extent", "external", "extract", "extreme",
  "facility", "factor", "faculty", "fade", "fail",
  "fairly", "faith", "fame", "famine", "fascinate",
  "fatal", "fate", "fatigue", "fault", "feature",
  "federal", "feedback", "fiction", "field",
  "file", "filter", "finance", "firm", "fiscal",
  "flame", "flash", "flee", "flexible",
  "float", "flock", "flourish", "fluctuate", "focus",
  "fold", "folk", "forbid", "forecast", "formula",
  "fortune", "forum", "fossil", "foster",
  "foundation", "fraction", "fragment", "framework",
  "frank", "fraud", "frequency", "friction",
  "frontier", "frustrate", "fuel", "fulfil",
  "function", "fund", "fundamental",
  "gallery", "gap", "gather", "gaze", "gear",
  "gender", "gene", "generate", "generous", "genetic",
  "genius", "genre", "genuine", "gesture",
  "glance", "glimpse", "globe", "grab", "grace",
  "gradual", "grant", "graphic", "grasp", "grave",
  "gravity", "grief", "grim", "grin", "grip", "gross",
  "guarantee", "guidance", "guideline", "guilt",
  "halt", "handful", "handle",
  "harsh", "harvest", "hazard", "headline",
  "heal", "heap",
  "highlight", "highly", "highway",
  "hint", "hire",
  "historic", "hollow", "horizon", "horror",
  "hostile", "household", "housing", "humble",
  "hypothesis",
  "icon", "ideal", "identical",
  "identity", "ideology", "ignorance", "illustrate",
  "image", "imagination", "imitation", "immense",
  "immigrant", "immune", "impact", "implement",
  "implication", "imply", "import", "impose", "impress",
  "impression", "impulse", "incentive", "incident",
  "incline", "income", "incorporate", "incredible",
  "independent", "index", "indicate",
  "indirect", "individual", "industrial", "inevitable",
  "infant", "infection", "inflation", "influence",
  "inform", "ingredient", "inhabit", "inherit",
  "inhibit", "initial", "initiate", "inject", "injure",
  "inner", "innocent", "innovation",
  "input", "inquiry", "insert",
  "insight", "inspect", "inspire", "install",
  "instance", "instinct", "institute", "instruct",
  "insult", "insurance", "intact", "integrate",
  "integrity", "intellectual", "intelligence",
  "intense", "intention", "interact", "interfere",
  "interior", "internal", "interpret", "interval",
  "intervene", "intimate", "invade", "invent",
  "invest", "investigate", "investment", "invisible",
  "invitation", "involve", "irony", "isolate", "issue",
  "item",
  "jealous", "joint", "journal",
  "judgment", "jungle", "junior",
  "jury", "justify",
  "kidnap",
  "label", "laboratory", "labour", "lack",
  "landscape", "lane", "launch", "layer", "layout",
  "league", "leak", "lean", "leap", "legacy",
  "legal", "legend", "legislation", "legitimate",
  "leisure", "lens",
  "liability", "liberal", "liberty", "likelihood",
  "likewise", "limitation",
  "link", "literacy", "literal", "literary",
  "livelihood", "lively",
  "loan", "lobby", "locate", "log",
  "logic", "loop",
  "loyal", "lump", "lure", "luxury",
  "magnetic", "magnificent", "magnitude",
  "maintain", "major",
  "mandate", "manifest", "manipulate", "manner",
  "manufacture", "margin",
  "marine", "massive",
  "master",
  "maximize", "mechanism",
  "media", "mediate", "membership",
  "memorial",
  "mere", "merge", "merit",
  "migrant", "military",
  "mineral", "minimal", "minimize", "minimum", "ministry",
  "minority", "miracle", "mirror",
  "miserable", "mislead", "mission",
  "mobile", "mobilize", "mode", "moderate", "modest",
  "modify", "module", "molecule", "monitor",
  "monopoly", "monster", "monument", "mood",
  "moral", "moreover",
  "mortgage", "motion", "motivate",
  "mount", "multiple", "multiply", "municipal", "mutual",
  "mystery", "myth",
  "naked", "narrative", "narrow", "nasty",
  "nationwide", "native", "natural",
  "navigation", "necessarily",
  "negative", "neglect", "negotiate", "nerve",
  "nest", "neutral", "nevertheless", "niche",
  "nightmare", "nominate", "nonetheless",
  "norm", "normal", "notable", "notice", "notify",
  "notion", "notorious", "nourish", "novel",
  "nurture", "nutrient", "nutrition",
  "obey", "object", "objective", "obligation",
  "observe", "obsess", "obstacle", "obtain", "obvious",
  "occasion", "occupy", "occur", "offence", "offend",
  "offer", "offset",
  "omit", "ongoing",
  "operate", "opinion", "opponent", "oppose",
  "option", "orbit",
  "organ", "organic", "organism", "organization", "orient",
  "origin", "original",
  "outbreak", "outcome",
  "outline", "output", "outrage",
  "outstanding", "overall", "overcome", "overlap",
  "overlook", "overseas", "overwhelm",
  "owe",
  "pace", "package", "panel", "panic", "paradox", "parallel",
  "parameter", "parliament", "partial",
  "participate", "particle", "partnership", "passage",
  "passion", "passive",
  "patience", "patrol",
  "pause", "peak",
  "peculiar", "peer", "penalty", "penetrate",
  "pension", "perceive", "percentage", "perception",
  "perfect", "perform", "perhaps", "periodic",
  "permanent", "permission", "persist", "personality",
  "personnel", "perspective", "persuade", "petition",
  "phase", "phenomenon", "philosophy", "phrase",
  "physical", "pioneer",
  "plague", "plead", "pledge",
  "plenty", "plight", "plot",
  "plunge", "poetry", "poison",
  "poll", "pollution",
  "populate", "portable", "portion", "portrait", "pose",
  "position", "positive", "possess",
  "postpone", "potential", "pound",
  "poverty", "powerful",
  "praise", "prayer", "preach",
  "precaution", "precede", "precedent", "precise",
  "predict", "pregnant",
  "prejudice", "preliminary", "premier", "premise",
  "premium", "preoccupy", "prescription", "presence",
  "presentation", "preserve", "preside",
  "prestigious", "presumably", "prevail", "prevent",
  "preview", "previous", "prey",
  "primarily", "primary", "prime", "primitive", "principal",
  "prior", "priority", "privacy", "privilege",
  "probe", "proceed", "proceedings", "process",
  "proclaim", "produce", "productivity", "profession",
  "profile", "profound", "programme", "progressive",
  "prohibit", "project", "prominent", "promise",
  "promote", "prompt", "prone", "proof", "propaganda",
  "proper", "property", "proportion", "proposal",
  "propose", "proposition", "prosecute", "prospect",
  "prosperity", "protect", "protein", "protest",
  "protocol", "prototype", "proud", "prove", "provide",
  "province", "provision", "provoke",
  "psychology", "publication", "publicity", "publish",
  "pump", "punch", "punish", "pupil",
  "purchase", "pursue", "puzzle",
  "qualify", "qualitative",
  "radical",
  "rally", "random", "range", "rank",
  "ratio", "rational", "raw", "react", "readily", "realistic",
  "rebel", "recession", "recipe", "recipient",
  "reckon", "recognition", "recommend",
  "reconcile", "recover", "recreation",
  "recruit", "recycle",
  "refer", "reference", "referendum", "reflect", "reform",
  "refuge", "refund", "refusal",
  "regain", "regard", "regime", "register", "regulate",
  "rehabilitate", "reign", "reinforce", "reject",
  "relate", "release", "relevant", "reliable",
  "relief", "religion", "relocate", "reluctant",
  "rely", "remain", "remark", "remedy", "remind",
  "remnant", "remote", "removal",
  "render", "renew", "renowned", "rent", "repair",
  "repay", "repeat", "replace", "represent",
  "repression", "reproduce", "republic", "reputation",
  "request", "require", "rescue", "resemble",
  "resent", "reserve", "reside", "resident", "resign",
  "resist", "resolution", "resolve", "resort",
  "resource", "respond", "restore", "restrain",
  "restrict", "result", "resume", "retail", "retain",
  "retire", "retreat", "retrieve", "reveal", "revenge",
  "revenue", "reverse", "review", "revise", "revive",
  "revolt", "revolution", "reward", "rhetoric",
  "rhythm", "rid", "ridiculous",
  "rigid", "riot", "rip", "ritual", "rival",
  "robust", "role", "roll",
  "rotate", "routine", "royal",
  "ruin", "ruler", "rural",
  "sacred", "sacrifice",
  "sail", "sake", "salary",
  "sanction", "satellite",
  "satisfaction", "scale", "scandal",
  "scenario", "scene", "scent", "schedule", "scheme",
  "scholar", "scope",
  "scream", "screen", "script", "scrutiny",
  "seal", "search", "season",
  "secret", "secular", "secure", "security", "segment",
  "seize", "select", "senior", "sensation", "sensitive",
  "sentence", "sentiment", "separate", "sequence",
  "serial", "session", "settle", "severe",
  "shadow", "shallow", "shame", "shelter", "shield",
  "shift", "shock", "shoot", "shore", "shortage",
  "shortly", "shrink", "shrug",
  "siege", "sight",
  "simulate", "simultaneous",
  "sincere", "site",
  "sceptical", "sketch", "skilled", "skip",
  "slam", "slave",
  "slice", "slight", "slogan", "slope",
  "smart", "smash", "smooth", "snap",
  "soar", "soccer", "social",
  "solar", "sole", "solemn", "solid", "solidarity",
  "sophisticated", "soul", "sound", "source", "sovereign",
  "span", "spare", "spark", "spatial", "specialist",
  "species", "specific", "specify", "specimen",
  "spectacle", "spectacular", "spectrum", "speculate",
  "sphere", "spill", "spin", "spine", "spiral",
  "spirit", "spiritual", "spite", "splash",
  "split", "spoil", "sponsor", "spot",
  "spouse", "spray", "spread", "spring",
  "squad", "square", "squeeze", "stability",
  "stake", "stall", "stance",
  "stark", "statue", "status", "steady",
  "steep", "stem", "stereotype", "stern",
  "stick", "stiff", "stimulate", "stir",
  "stock", "stomach", "strain", "strand", "strategy",
  "stream", "strengthen", "stress",
  "stretch", "strict", "stride", "strike", "string",
  "strip", "stroke", "structure", "struggle", "stubborn",
  "studio", "stuff", "stumble", "stun",
  "style", "subject", "submit", "subsequent",
  "subsidy", "substance", "substantial", "substitute",
  "subtle", "suburb",
  "succeed", "success", "successor",
  "sue", "sufficient", "suggestion", "suicide",
  "suit", "suite", "sum", "summit",
  "superb", "superior", "supplement", "supply",
  "support", "suppose", "supreme", "surge",
  "surplus", "surrender", "surround", "survey",
  "survival", "suspect", "suspend", "suspicion",
  "sustain", "swap", "swift", "switch",
  "symbol", "sympathy", "symptom", "syndrome",
  "synthesis", "systematic",
  "tablet", "tackle", "tactics", "tag", "tale",
  "talent", "target", "tariff",
  "task", "taste", "tax", "technique", "technology",
  "temple", "temporary", "temptation",
  "tenant", "tendency", "tender", "tension", "tent",
  "tenure", "term", "terminal", "territory",
  "terror", "testimony", "texture", "theme", "therapy",
  "thereby", "thesis", "thorough", "threaten",
  "threshold", "thrill", "thrive", "throne", "thrust",
  "thumb", "tide", "tight", "timber", "timing",
  "tissue", "token", "tolerance", "tone", "topic",
  "torture", "tournament", "trace",
  "track", "tract", "tradition", "tragedy", "trail",
  "trait", "transaction", "transform", "transit",
  "transmission", "transparent", "transport", "trap",
  "trauma", "treaty", "tremble", "tremendous",
  "trend", "trial", "tribe", "tribunal",
  "tribute", "trigger", "triumph",
  "troop", "trophy", "trouble",
  "trunk", "trust", "truth",
  "tube", "tuition", "tune", "tunnel", "turbulence",
  "twist",
  "ultimate", "umbrella", "unanimous", "undergo",
  "undermine", "undertake", "uniform", "unify",
  "union", "unique", "unity", "universal", "universe",
  "unprecedented", "update", "upgrade", "uphold",
  "upper", "uprising", "upset", "urban", "urge",
  "utilize",
  "vacant", "vacuum", "vague", "valid", "valley",
  "valuable", "variable", "variation", "variety",
  "various", "vary", "vast", "vegetation", "vehicle",
  "venture", "venue", "verbal", "verdict", "verify",
  "versatile", "version", "versus",
  "vertical", "vessel", "veteran", "viable", "vibrant",
  "victim", "victory", "video", "view", "violate",
  "violence", "virtual", "virtue", "virus", "visible",
  "vision", "visual", "vital", "vivid", "vocabulary",
  "volume", "voluntary",
  "vulnerable",
  "wage", "wander", "warrant",
  "wealthy", "weapon", "welfare",
  "widespread", "willingness",
  "withdraw", "withhold", "workforce",
  "workshop", "worship", "worthwhile", "wound",
  "wrap", "wrist",
  "yield",
])

const LEVEL_WORDS: Record<string, Set<string>> = {
  "A1": CEFR_A1,
  "A2": CEFR_A2,
  "B1": CEFR_B1,
}

interface DictEntry {
  word: string
  phonetic: string
  meanings: {
    partOfSpeech: string
    definitions: {
      definition: string
      example: string
    }[]
  }[]
}

function isWorthHighlighting(word: string, level: string): boolean {
  if (word.length <= 2) return false
  const lower = word.toLowerCase()
  if (STOP_WORDS.has(lower)) return false
  if (/^\d+$/.test(lower)) return false

  const levelIndex = ["A1", "A2", "B1", "B2", "C1"].indexOf(level)
  if (levelIndex === -1) return false

  const targetLevels = ["A1", "A2", "B1"].slice(0, levelIndex + 1)
  for (const lvl of targetLevels) {
    if (LEVEL_WORDS[lvl]?.has(lower)) return true
  }

  if (lower.length > 5 && levelIndex >= 2) return true
  if (lower.length > 7 && levelIndex >= 3) return true
  if (lower.length > 9 && levelIndex >= 4) return true

  return false
}

async function fetchDictionaryData(word: string): Promise<DictEntry | null> {
  try {
    const res = await fetch(`${FREE_DICT_API}/${encodeURIComponent(word)}`, {
      headers: { "Accept": "application/json" },
    })
    if (!res.ok) return null
    const data = await res.json()
    if (!Array.isArray(data) || data.length === 0) return null

    const entry = data[0]
    const phonetic = entry.phonetic || entry.phonetics?.[0]?.text || ""

    const meanings = (entry.meanings || []).map((m: any) => ({
      partOfSpeech: m.partOfSpeech || "",
      definitions: (m.definitions || []).slice(0, 2).map((d: any) => ({
        definition: d.definition || "",
        example: d.example || "",
      })),
    }))

    return { word, phonetic, meanings }
  } catch {
    return null
  }
}

function generateFallbackDict(word: string): DictEntry {
  const lower = word.toLowerCase()
  let phonetic = ""
  if (lower.length > 0) {
    const first = lower[0]
    const rest = lower.slice(1)
    phonetic = `/${first}/` 
  }

  return {
    word: lower,
    phonetic,
    meanings: [
      {
        partOfSpeech: "noun",
        definitions: [
          {
            definition: `The word "${lower}" refers to a concept, action, or thing.`,
            example: `The ${lower} is important in this context.`,
          },
        ],
      },
    ],
  }
}

serve(async (req) => {
  try {
    if (req.method !== "POST") {
      return new Response(JSON.stringify({ error: "Method not allowed" }), {
        status: 405,
        headers: { "Content-Type": "application/json" },
      })
    }

    const body = await req.json()
    const rawText: string = (body.raw_text || "").trim()
    const cefrLevel: string = (body.cefr_level || "B1").toUpperCase()
    const articleTitle: string = (body.article_title || "").trim()

    if (!rawText) {
      return new Response(JSON.stringify({
        article_title: articleTitle,
        cefr_level: cefrLevel,
        segments: [],
      }), {
        headers: { "Content-Type": "application/json" },
      })
    }

    const validLevels = ["A1", "A2", "B1", "B2", "C1"]
    const level = validLevels.includes(cefrLevel) ? cefrLevel : "B1"

    const sentences = splitSentences(rawText)

    const wordCache = new Map<string, DictEntry>()

    async function getDictData(word: string): Promise<DictEntry> {
      const lower = word.toLowerCase()
      if (wordCache.has(lower)) return wordCache.get(lower)!
      const data = await fetchDictionaryData(lower)
      const result = data || generateFallbackDict(lower)
      wordCache.set(lower, result)
      return result
    }

    const segments = []
    for (let i = 0; i < sentences.length; i++) {
      const cleaned = cleanText(sentences[i])
      if (!cleaned) continue

      const tokens = wordTokens(cleaned)
      const uniqueWords = [...new Set(tokens)]
      const highlightCandidates = uniqueWords.filter(w => isWorthHighlighting(w, level))

      const highlightedWordsData: DictEntry[] = []
      for (const w of highlightCandidates.slice(0, 5)) {
        const data = await getDictData(w)
        if (data) highlightedWordsData.push(data)
      }

      const highlightedWords = highlightedWordsData.map(h => h.word)

      segments.push({
        id: i + 1,
        clean_text: cleaned,
        highlighted_words: highlightedWords,
        highlighted_words_data: highlightedWordsData,
      })
    }

    const result = {
      article_title: articleTitle,
      cefr_level: level,
      segments,
    }

    return new Response(JSON.stringify(result), {
      headers: { "Content-Type": "application/json" },
    })
  } catch (err) {
    return new Response(JSON.stringify({
      error: String(err),
      article_title: "",
      cefr_level: "",
      segments: [],
    }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    })
  }
})
