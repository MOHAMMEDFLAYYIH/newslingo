-- =============================================================
-- NewsLingo Seed Articles
-- Run this AFTER supabase_schema.sql in Supabase SQL Editor
-- =============================================================

-- Clear existing seed data (safe to re-run)
DELETE FROM bookmarks WHERE article_id IN ('seed_1','seed_2','seed_3','seed_4','seed_5','seed_6','seed_7','seed_8');
DELETE FROM articles WHERE id IN ('seed_1','seed_2','seed_3','seed_4','seed_5','seed_6','seed_7','seed_8');

-- =============================================================
-- Article 1: Clean Energy Breakthrough (technology, B2)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_1',
  'علماء يكتشفون طريقة جديدة لتوليد الطاقة النظيفة',
  'اكتشاف علمي رائد يكشف عن طريقة جديدة لتوليد الطاقة النظيفة باستخدام تقنية الاندماج النووي.',
  'A groundbreaking scientific discovery has revealed a new method for generating clean energy that could revolutionize the <highlight>sustainable</highlight> power industry. Researchers at the Global Energy Institute announced a <highlight>significant</highlight> <highlight>breakthrough</highlight> in fusion technology that promises unlimited clean energy.\n\nThe new approach, which has been in development for over a decade, uses advanced magnetic fields to contain plasma at extremely high temperatures. This <highlight>comprehensive</highlight> method addresses many of the challenges that have previously prevented <highlight>widespread</highlight> adoption of fusion power.\n\n<highlight>Despite</highlight> earlier skepticism from some experts, the team was able to <highlight>implement</highlight> a novel cooling system that maintains stability for longer periods. <highlight>Consequently</highlight>, the reactor can now operate <highlight>sustainably</highlight> for extended durations, marking a major step toward commercial viability.\n\nThe <highlight>emerging</highlight> technology has attracted attention from governments and private investors worldwide.',
  'technology',
  'Science Daily',
  'B2',
  NOW() - INTERVAL '3 hours',
  ARRAY['energy', 'science', 'fusion', 'clean-energy'],
  $$[
    {"word": "sustainable", "definition": "able to be maintained at a certain rate or level over time", "translation": "مستدام", "synonyms": ["maintainable", "renewable", "viable"], "examples": ["Solar energy is a sustainable power source.", "The company focuses on sustainable development."], "part_of_speech": "adjective"},
    {"word": "significant", "definition": "sufficiently great or important to be worthy of attention", "translation": "كبير/مهم", "synonyms": ["notable", "remarkable", "substantial"], "examples": ["There has been a significant increase in sales.", "This is a significant achievement for the team."], "part_of_speech": "adjective"},
    {"word": "breakthrough", "definition": "a sudden, dramatic, and important discovery or development", "translation": "اختراق", "synonyms": ["discovery", "innovation", "advancement"], "examples": ["The scientists made a major breakthrough in cancer research.", "This breakthrough could change the world."], "part_of_speech": "noun"},
    {"word": "comprehensive", "definition": "including or dealing with all or nearly all elements or aspects of something", "translation": "شامل", "synonyms": ["complete", "thorough", "extensive"], "examples": ["We need a comprehensive review of the system.", "The report provides a comprehensive analysis."], "part_of_speech": "adjective"},
    {"word": "widespread", "definition": "found or distributed over a large area or number of people", "translation": "واسع الانتشار", "synonyms": ["extensive", "broad", "prevalent"], "examples": ["The disease is widespread in rural areas.", "There is widespread support for the new policy."], "part_of_speech": "adjective"},
    {"word": "despite", "definition": "without being affected by; in spite of", "translation": "بالرغم من", "synonyms": ["notwithstanding", "regardless of", "even with"], "examples": ["Despite the rain, they continued playing.", "She succeeded despite many difficulties."], "part_of_speech": "preposition"},
    {"word": "implement", "definition": "put a decision, plan, or agreement into effect", "translation": "ينفذ", "synonyms": ["execute", "apply", "carry out"], "examples": ["The company will implement the new policy next month.", "We need to implement these changes carefully."], "part_of_speech": "verb"},
    {"word": "consequently", "definition": "as a result or effect of something", "translation": "وبالتالي", "synonyms": ["therefore", "thus", "hence", "accordingly"], "examples": ["He was late and consequently missed the bus.", "The temperature dropped; consequently, the pipes froze."], "part_of_speech": "adverb"},
    {"word": "sustainably", "definition": "in a way that can be maintained over the long term without harming the environment", "translation": "بشكل مستدام", "synonyms": ["responsibly", "renewably", "ecologically"], "examples": ["The forest is managed sustainably.", "We must produce energy more sustainably."], "part_of_speech": "adverb"},
    {"word": "emerging", "definition": "newly developed or just becoming noticeable", "translation": "ناشئ", "synonyms": ["developing", "growing", "rising"], "examples": ["Emerging technologies are changing our lives.", "The emerging market shows great potential."], "part_of_speech": "adjective"}
  ]$$,
  $${
    "id": "quiz_seed_1",
    "article_id": "seed_1",
    "questions": [
      {"question": "What does 'sustainable' most closely mean?", "options": ["able to continue over time", "very fast", "extremely large", "completely new"], "correct_index": 0},
      {"question": "What did researchers announce a breakthrough in?", "options": ["solar panels", "wind turbines", "fusion technology", "battery storage"], "correct_index": 2},
      {"question": "What does the new method use to contain plasma?", "options": ["lasers", "magnetic fields", "chemical reactions", "steam pressure"], "correct_index": 1},
      {"question": "What does 'despite' mean?", "options": ["because of", "in addition to", "in spite of", "as a result of"], "correct_index": 2},
      {"question": "What has the emerging technology attracted?", "options": ["criticism", "attention from governments and investors", "legal challenges", "public protests"], "correct_index": 1}
    ]
  }$$
);

-- =============================================================
-- Article 2: Morocco World Cup (sports, B1)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_2',
  'منتخب المغرب يحقق فوزاً تاريخياً في كأس العالم',
  'المنتخب المغربي يسجل إنجازاً غير مسبوق بوصوله إلى نصف نهائي كأس العالم.',
  'In a stunning turn of events, the Moroccan national team has <highlight>secured</highlight> a historic victory that has sent shockwaves through the football world. The team''s <highlight>remarkable</highlight> journey to the World Cup semi-finals represents a <highlight>significant</highlight> achievement for African football.\n\nThe squad, led by an <highlight>exceptional</highlight> coaching staff, demonstrated <highlight>outstanding</highlight> teamwork and <highlight>resilience</highlight> throughout the tournament. Their <highlight>impressive</highlight> performance has <highlight>inspired</highlight> millions around the globe.',
  'sports',
  'BBC Sport',
  'B1',
  NOW() - INTERVAL '5 hours',
  ARRAY['football', 'world-cup', 'morocco', 'history'],
  $$[
    {"word": "secured", "definition": "obtained or achieved something, especially with effort", "translation": "حصل على / ضمن", "synonyms": ["obtained", "achieved", "gained"], "examples": ["The team secured their place in the final.", "She secured a job at the company."], "part_of_speech": "verb"},
    {"word": "remarkable", "definition": "worthy of attention; striking or extraordinary", "translation": "رائع / مميز", "synonyms": ["extraordinary", "notable", "impressive"], "examples": ["He made a remarkable recovery.", "It was a remarkable achievement."], "part_of_speech": "adjective"},
    {"word": "significant", "definition": "sufficiently great or important to be worthy of attention", "translation": "كبير / مهم", "synonyms": ["notable", "considerable", "substantial"], "examples": ["This is a significant moment in history.", "There was a significant improvement."], "part_of_speech": "adjective"},
    {"word": "exceptional", "definition": "unusually good; outstanding", "translation": "استثنائي", "synonyms": ["extraordinary", "remarkable", "unparalleled"], "examples": ["Her performance was exceptional.", "He is an exceptional student."], "part_of_speech": "adjective"},
    {"word": "outstanding", "definition": "exceptionally good; extremely impressive", "translation": "ممتاز / بارز", "synonyms": ["excellent", "superb", "exceptional"], "examples": ["She received an award for outstanding work.", "The team gave an outstanding performance."], "part_of_speech": "adjective"},
    {"word": "resilience", "definition": "the ability to recover quickly from difficulties", "translation": "مرونة / قدرة على التعافي", "synonyms": ["toughness", "perseverance", "adaptability"], "examples": ["The community showed great resilience after the disaster.", "His resilience helped him overcome challenges."], "part_of_speech": "noun"},
    {"word": "impressive", "definition": "evoking admiration through size, quality, or skill", "translation": "مثير للإعجاب", "synonyms": ["striking", "remarkable", "awe-inspiring"], "examples": ["The view from the top was impressive.", "She gave an impressive speech."], "part_of_speech": "adjective"},
    {"word": "inspired", "definition": "motivated or encouraged to do something creative or positive", "translation": "ألهم", "synonyms": ["motivated", "encouraged", "stimulated"], "examples": ["The speech inspired the whole audience.", "Her story inspired many young people."], "part_of_speech": "verb"}
  ]$$,
  $${
    "id": "quiz_seed_2",
    "article_id": "seed_2",
    "questions": [
      {"question": "What did the Moroccan national team secure?", "options": ["a friendly match win", "a historic victory", "a sponsorship deal", "a coaching change"], "correct_index": 1},
      {"question": "What does 'remarkable' mean?", "options": ["ordinary", "forgettable", "extraordinary", "common"], "correct_index": 2},
      {"question": "Which tournament are they competing in?", "options": ["Olympics", "African Cup", "World Cup", "European Championship"], "correct_index": 2},
      {"question": "What does 'resilience' mean?", "options": ["ability to give up", "ability to stay strong through difficulties", "ability to run fast", "ability to score goals"], "correct_index": 1},
      {"question": "How has their performance affected people globally?", "options": ["depressed them", "inspired them", "confused them", "bored them"], "correct_index": 1}
    ]
  }$$
);

-- =============================================================
-- Article 3: AI in Education (technology, B2)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_3',
  'الذكاء الاصطناعي يحدث ثورة في مجال التعليم',
  'تقنيات الذكاء الاصطناعي التوليدي تغير طريقة تعلم الطلاب حول العالم.',
  'Artificial intelligence is <highlight>transforming</highlight> education in ways that were once <highlight>unimaginable</highlight>. From personalized learning paths to <highlight>intelligent</highlight> tutoring systems, AI is making education more <highlight>accessible</highlight> and <highlight>effective</highlight> than ever before.\n\nEducators are <highlight>embracing</highlight> these new tools to create <highlight>engaging</highlight> learning experiences that adapt to each student''s needs. The <highlight>potential</highlight> for AI to <highlight>revolutionize</highlight> education is <highlight>enormous</highlight>, particularly in developing regions where access to quality teachers is limited.',
  'technology',
  'TechCrunch',
  'B2',
  NOW() - INTERVAL '8 hours',
  ARRAY['ai', 'education', 'technology', 'learning'],
  $$[
    {"word": "transforming", "definition": "making a thorough or dramatic change in form, appearance, or character", "translation": "يحول / يغير", "synonyms": ["changing", "converting", "revolutionizing"], "examples": ["Technology is transforming the way we live.", "The company is transforming its business model."], "part_of_speech": "verb"},
    {"word": "unimaginable", "definition": "impossible to imagine or comprehend", "translation": "لا يمكن تخيله", "synonyms": ["inconceivable", "unthinkable", "incredible"], "examples": ["The scale of the problem was unimaginable.", "They faced unimaginable challenges."], "part_of_speech": "adjective"},
    {"word": "intelligent", "definition": "having or showing the ability to think, learn, and understand", "translation": "ذكي", "synonyms": ["smart", "clever", "bright"], "examples": ["She is an intelligent student.", "The system uses intelligent algorithms."], "part_of_speech": "adjective"},
    {"word": "accessible", "definition": "able to be reached, entered, or used easily", "translation": "متاح / يمكن الوصول إليه", "synonyms": ["available", "reachable", "approachable"], "examples": ["The building is accessible to wheelchair users.", "Online education makes learning more accessible."], "part_of_speech": "adjective"},
    {"word": "effective", "definition": "successful in producing a desired or intended result", "translation": "فعال", "synonyms": ["efficient", "productive", "successful"], "examples": ["The new medicine is very effective.", "We need an effective strategy."], "part_of_speech": "adjective"},
    {"word": "embracing", "definition": "accepting or supporting a new idea or change willingly", "translation": "يتبنى", "synonyms": ["adopting", "welcoming", "accepting"], "examples": ["Companies are embracing digital transformation.", "She embraced the new opportunity."], "part_of_speech": "verb"},
    {"word": "engaging", "definition": "attractive, interesting, or appealing", "translation": "جذاب / مشوق", "synonyms": ["captivating", "absorbing", "compelling"], "examples": ["The teacher made the lesson very engaging.", "It was an engaging story."], "part_of_speech": "adjective"},
    {"word": "potential", "definition": "latent qualities or abilities that may be developed", "translation": "إمكانات", "synonyms": ["capability", "capacity", "promise"], "examples": ["She has great potential as a writer.", "The technology has enormous potential."], "part_of_speech": "noun"},
    {"word": "revolutionize", "definition": "change something fundamentally or dramatically", "translation": "يحدث ثورة في", "synonyms": ["transform", "overhaul", "dramatically change"], "examples": ["The internet revolutionized communication.", "This invention could revolutionize medicine."], "part_of_speech": "verb"},
    {"word": "enormous", "definition": "very large in size, quantity, or extent", "translation": "ضخم", "synonyms": ["huge", "massive", "immense"], "examples": ["The project requires an enormous amount of work.", "There is an enormous difference between them."], "part_of_speech": "adjective"}
  ]$$,
  $${
    "id": "quiz_seed_3",
    "article_id": "seed_3",
    "questions": [
      {"question": "How is AI described as changing education?", "options": ["destroying it", "transforming it", "ignoring it", "slowing it down"], "correct_index": 1},
      {"question": "What does 'accessible' mean?", "options": ["expensive", "difficult to use", "easy to reach or use", "hidden"], "correct_index": 2},
      {"question": "What are educators doing with AI tools?", "options": ["rejecting them", "embracing them", "ignoring them", "fearing them"], "correct_index": 1},
      {"question": "What does 'engage' mean in this context?", "options": ["to fight", "to hold attention and interest", "to employ", "to promise"], "correct_index": 1},
      {"question": "Where is AI's potential in education especially important?", "options": ["wealthy countries", "developing regions", "large cities", "private schools"], "correct_index": 1}
    ]
  }$$
);

-- =============================================================
-- Article 4: Apple Launch (technology, B1)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_4',
  'شركة أبل تطلق هاتفها الجديد بتقنية ثورية',
  'أبل تعلن عن أحدث إصداراتها مع ميزات ذكاء اصطناعي متقدمة.',
  'Apple has <highlight>unveiled</highlight> its latest smartphone featuring <highlight>groundbreaking</highlight> AI capabilities. The new device <highlight>incorporates</highlight> advanced machine learning processors that enable <highlight>sophisticated</highlight> features never before seen in a smartphone.\n\nThe company''s CEO described the launch as a <highlight>significant</highlight> milestone, emphasizing how the new technology will <highlight>enhance</highlight> user experience. Industry analysts have <highlight>praised</highlight> the innovation, predicting it will <highlight>influence</highlight> the entire smartphone market.',
  'technology',
  'The Verge',
  'B1',
  NOW() - INTERVAL '12 hours',
  ARRAY['apple', 'iphone', 'ai', 'smartphone'],
  $$[
    {"word": "unveiled", "definition": "revealed or made public for the first time", "translation": "كشف عن", "synonyms": ["revealed", "uncovered", "launched"], "examples": ["The company unveiled its new product at the event.", "The plan was unveiled yesterday."], "part_of_speech": "verb"},
    {"word": "groundbreaking", "definition": "innovative and pioneering in a way that creates new opportunities", "translation": "رائد / ثوري", "synonyms": ["innovative", "pioneering", "revolutionary"], "examples": ["The research represents a groundbreaking discovery.", "It was a groundbreaking achievement in technology."], "part_of_speech": "adjective"},
    {"word": "incorporates", "definition": "includes or contains something as part of a whole", "translation": "يدمج / يتضمن", "synonyms": ["includes", "integrates", "embodies"], "examples": ["The new design incorporates many features.", "The software incorporates advanced security."], "part_of_speech": "verb"},
    {"word": "sophisticated", "definition": "complex, advanced, and highly developed", "translation": "متطور", "synonyms": ["advanced", "complex", "refined"], "examples": ["The system uses sophisticated technology.", "She has a sophisticated understanding of the topic."], "part_of_speech": "adjective"},
    {"word": "significant", "definition": "sufficiently great or important to be worthy of attention", "translation": "مهم / كبير", "synonyms": ["notable", "considerable", "important"], "examples": ["This is a significant moment in history.", "There was a significant improvement."], "part_of_speech": "adjective"},
    {"word": "enhance", "definition": "increase the quality, value, or effectiveness of something", "translation": "يعزز / يحسن", "synonyms": ["improve", "boost", "upgrade"], "examples": ["The new features enhance the user experience.", "Exercise can enhance your mood."], "part_of_speech": "verb"},
    {"word": "praised", "definition": "expressed warm approval or admiration for someone or something", "translation": "أشاد بـ", "synonyms": ["commended", "applauded", "complimented"], "examples": ["Critics praised the film.", "The teacher praised her students."], "part_of_speech": "verb"},
    {"word": "influence", "definition": "the capacity to have an effect on someone or something", "translation": "يؤثر على", "synonyms": ["affect", "shape", "impact"], "examples": ["The speech influenced many voters.", "Social media can influence public opinion."], "part_of_speech": "verb"}
  ]$$,
  $${
    "id": "quiz_seed_4",
    "article_id": "seed_4",
    "questions": [
      {"question": "What did Apple unveil?", "options": ["a new laptop", "its latest smartphone", "a smartwatch", "a tablet"], "correct_index": 1},
      {"question": "What does 'groundbreaking' mean?", "options": ["traditional", "ordinary", "innovative and pioneering", "dangerous"], "correct_index": 2},
      {"question": "What kind of processors does the new device feature?", "options": ["basic processors", "quantum processors", "advanced machine learning processors", "outdated processors"], "correct_index": 2},
      {"question": "What does 'enhance' mean?", "options": ["reduce", "ignore", "improve", "damage"], "correct_index": 2},
      {"question": "How are industry analysts described as reacting?", "options": ["praising the innovation", "criticizing the launch", "ignoring the product", "doubting the company"], "correct_index": 0}
    ]
  }$$
);

-- =============================================================
-- Article 5: Climate Summit (science, B2)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_5',
  'تغير المناخ: قمة عالمية تتفق على خفض الانبعاثات',
  'قادة العالم يتوصلون إلى اتفاق تاريخي لتقليل انبعاثات الكربون.',
  'World leaders have <highlight>reached</highlight> a historic agreement to <highlight>dramatically</highlight> reduce carbon emissions over the next decade. The <highlight>ambitious</highlight> plan <highlight>commits</highlight> signatory nations to <highlight>substantial</highlight> cuts in greenhouse gas emissions, marking a <highlight>crucial</highlight> step in the fight against climate change.\n\nEnvironmental experts have <highlight>welcomed</highlight> the agreement but <highlight>emphasize</highlight> the need for <highlight>immediate</highlight> action. The <highlight>implementation</highlight> of these measures will require <highlight>unprecedented</highlight> cooperation between nations.',
  'science',
  'Reuters',
  'B2',
  NOW() - INTERVAL '24 hours',
  ARRAY['climate', 'environment', 'emissions', 'global'],
  $$[
    {"word": "reached", "definition": "arrived at or achieved after effort", "translation": "توصل إلى", "synonyms": ["achieved", "attained", "arrived at"], "examples": ["They reached an agreement after long negotiations.", "We finally reached our goal."], "part_of_speech": "verb"},
    {"word": "dramatically", "definition": "in a way that is striking or very noticeable", "translation": "بشكل كبير / ملحوظ", "synonyms": ["significantly", "considerably", "sharply"], "examples": ["The price has dramatically increased.", "Her health improved dramatically."], "part_of_speech": "adverb"},
    {"word": "ambitious", "definition": "requiring great effort to achieve; challenging", "translation": "طموح", "synonyms": ["challenging", "demanding", "aspiring"], "examples": ["The project is very ambitious.", "They set ambitious goals for the year."], "part_of_speech": "adjective"},
    {"word": "commits", "definition": "dedicates or pledges to do something", "translation": "يلتزم", "synonyms": ["pledges", "obligates", "binds"], "examples": ["The government commits to reducing pollution.", "She commits herself to helping others."], "part_of_speech": "verb"},
    {"word": "substantial", "definition": "of considerable importance, size, or worth", "translation": "كبير / جوهري", "synonyms": ["considerable", "significant", "sizeable"], "examples": ["They made substantial progress.", "There is a substantial difference."], "part_of_speech": "adjective"},
    {"word": "crucial", "definition": "decisive or critical in determining the outcome", "translation": "حاسم", "synonyms": ["critical", "essential", "vital"], "examples": ["This is a crucial moment in the negotiations.", "Education is crucial for success."], "part_of_speech": "adjective"},
    {"word": "welcomed", "definition": "greeted or received with pleasure or approval", "translation": "رحب بـ", "synonyms": ["embraced", "accepted", "applauded"], "examples": ["The decision was welcomed by the community.", "They welcomed the new initiative."], "part_of_speech": "verb"},
    {"word": "emphasize", "definition": "give special importance or attention to something", "translation": "يؤكد على", "synonyms": ["highlight", "stress", "underscore"], "examples": ["The report emphasizes the need for change.", "She emphasized the importance of teamwork."], "part_of_speech": "verb"},
    {"word": "immediate", "definition": "occurring or done at once; without delay", "translation": "فوري", "synonyms": ["instant", "prompt", "urgent"], "examples": ["The patient needs immediate attention.", "They demanded immediate action."], "part_of_speech": "adjective"},
    {"word": "implementation", "definition": "the process of putting a decision or plan into effect", "translation": "تنفيذ", "synonyms": ["execution", "application", "enactment"], "examples": ["The implementation of the new system will take months.", "They are responsible for policy implementation."], "part_of_speech": "noun"},
    {"word": "unprecedented", "definition": "never done or known before; without previous example", "translation": "غير مسبوق", "synonyms": ["unparalleled", "unmatched", "exceptional"], "examples": ["The country faced unprecedented challenges.", "It was an unprecedented achievement."], "part_of_speech": "adjective"}
  ]$$,
  $${
    "id": "quiz_seed_5",
    "article_id": "seed_5",
    "questions": [
      {"question": "What did world leaders reach?", "options": ["a trade deal", "a historic agreement on emissions", "a peace treaty", "a sports contract"], "correct_index": 1},
      {"question": "What does 'ambitious' mean?", "options": ["easy to achieve", "lazy", "requiring great effort to achieve", "unimportant"], "correct_index": 2},
      {"question": "What will the plan reduce over the next decade?", "options": ["population", "carbon emissions", "oil prices", "internet usage"], "correct_index": 1},
      {"question": "What does 'crucial' mean?", "options": ["optional", "unimportant", "critical and decisive", "slow"], "correct_index": 2},
      {"question": "What will implementation of the measures require?", "options": ["unprecedented cooperation", "less funding", "fewer countries", "shorter timelines"], "correct_index": 0}
    ]
  }$$
);

-- =============================================================
-- Article 6: Cannes Film Festival (entertainment, B1)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_6',
  'انطلاق مهرجان كان السينمائي بنجوم هوليوود',
  'نجوم السينما العالمية يتألقون على السجادة الحمراء في مهرجان كان.',
  'The Cannes Film Festival has <highlight>officially</highlight> opened with a star-studded red carpet ceremony. This year''s festival <highlight>showcases</highlight> an <highlight>impressive</highlight> lineup of films from around the world, <highlight>highlighting</highlight> the best of <highlight>contemporary</highlight> cinema.\n\nCritics have <highlight>praised</highlight> the diversity of this year''s selection, which <highlight>includes</highlight> several <highlight>groundbreaking</highlight> works from emerging directors. The festival <highlight>continues</highlight> to be a <highlight>vital</highlight> platform for <highlight>celebrating</highlight> cinematic excellence.',
  'entertainment',
  'Variety',
  'B1',
  NOW() - INTERVAL '48 hours',
  ARRAY['cannes', 'film', 'festival', 'cinema'],
  $$[
    {"word": "officially", "definition": "in a formal or authorized way", "translation": "رسمياً", "synonyms": ["formally", "authoritatively", "legitimately"], "examples": ["The store officially opened yesterday.", "She was officially appointed as manager."], "part_of_speech": "adverb"},
    {"word": "showcases", "definition": "displays or presents something to best effect", "translation": "يعرض / يبرز", "synonyms": ["displays", "presents", "exhibits"], "examples": ["The museum showcases local artists.", "The event showcases new technology."], "part_of_speech": "verb"},
    {"word": "impressive", "definition": "evoking admiration through size, quality, or skill", "translation": "مثير للإعجاب", "synonyms": ["remarkable", "striking", "awe-inspiring"], "examples": ["Her performance was impressive.", "The building has an impressive design."], "part_of_speech": "adjective"},
    {"word": "highlighting", "definition": "drawing attention to or emphasizing something", "translation": "يسلط الضوء على", "synonyms": ["emphasizing", "stressing", "underscoring"], "examples": ["The report highlights the main issues.", "She highlighted the most important points."], "part_of_speech": "verb"},
    {"word": "contemporary", "definition": "living or occurring in the present time; modern", "translation": "معاصر", "synonyms": ["modern", "current", "present-day"], "examples": ["The museum features contemporary art.", "Contemporary music is very diverse."], "part_of_speech": "adjective"},
    {"word": "praised", "definition": "expressed warm approval or admiration", "translation": "أشاد بـ", "synonyms": ["commended", "applauded", "acclaimed"], "examples": ["Critics praised the director's work.", "Everyone praised his dedication."], "part_of_speech": "verb"},
    {"word": "includes", "definition": "contains as part of a whole", "translation": "يتضمن / يشمل", "synonyms": ["contains", "comprises", "encompasses"], "examples": ["The price includes breakfast.", "The team includes players from five countries."], "part_of_speech": "verb"},
    {"word": "groundbreaking", "definition": "innovative and pioneering", "translation": "رائد / مبتكر", "synonyms": ["innovative", "pioneering", "trailblazing"], "examples": ["The film was groundbreaking in its approach.", "It was a groundbreaking scientific study."], "part_of_speech": "adjective"},
    {"word": "continues", "definition": "persists in an activity or process", "translation": "يستمر", "synonyms": ["persists", "carries on", "keeps going"], "examples": ["The tradition continues to this day.", "She continues to improve her skills."], "part_of_speech": "verb"},
    {"word": "vital", "definition": "absolutely necessary or essential", "translation": "حيوي / أساسي", "synonyms": ["essential", "crucial", "critical"], "examples": ["Clean water is vital for health.", "Exercise is vital for well-being."], "part_of_speech": "adjective"},
    {"word": "celebrating", "definition": "marking a special occasion with festivities", "translation": "يحتفي بـ", "synonyms": ["commemorating", "honoring", "observing"], "examples": ["They are celebrating their anniversary.", "The festival celebrates cultural diversity."], "part_of_speech": "verb"}
  ]$$,
  $${
    "id": "quiz_seed_6",
    "article_id": "seed_6",
    "questions": [
      {"question": "How did the Cannes Film Festival open?", "options": ["quietly", "officially with a red carpet ceremony", "online only", "without any events"], "correct_index": 1},
      {"question": "What does 'showcases' mean?", "options": ["hides", "displays or presents", "criticizes", "ignores"], "correct_index": 1},
      {"question": "What have critics praised about this year's selection?", "options": ["its length", "its diversity", "its cost", "its location"], "correct_index": 1},
      {"question": "What does 'contemporary' mean?", "options": ["old-fashioned", "modern and current", "historical", "future"], "correct_index": 1},
      {"question": "What is the festival described as being for cinema?", "options": ["a minor event", "a vital platform", "an outdated tradition", "a local gathering"], "correct_index": 1}
    ]
  }$$
);

-- =============================================================
-- Article 7: Diabetes Treatment (science, C1)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_7',
  'اكتشاف علاج جديد لمرض السكري',
  'باحثون يطورون علاجاً مبتكراً لمرض السكري من النوع الأول.',
  'Scientists have <highlight>developed</highlight> a <highlight>promising</highlight> new treatment for Type 1 diabetes that could <highlight>significantly</highlight> improve the lives of millions. The <highlight>innovative</highlight> approach <highlight>combines</highlight> immunotherapy with stem cell technology to <highlight>restore</highlight> insulin production.\n\nClinical trials have shown <highlight>remarkable</highlight> results, with patients <highlight>experiencing</highlight> <highlight>substantial</highlight> improvements in blood sugar control. Researchers are <highlight>optimistic</highlight> about the treatment''s potential to <highlight>revolutionize</highlight> diabetes management.',
  'science',
  'Nature Medicine',
  'C1',
  NOW() - INTERVAL '2 days',
  ARRAY['diabetes', 'treatment', 'stem-cells', 'health'],
  $$[
    {"word": "developed", "definition": "created or designed something new over time", "translation": "طور / ابتكر", "synonyms": ["created", "designed", "devised"], "examples": ["The team developed a new software solution.", "Scientists developed a vaccine."], "part_of_speech": "verb"},
    {"word": "promising", "definition": "showing great potential or hope for the future", "translation": "واعد", "synonyms": ["encouraging", "hopeful", "auspicious"], "examples": ["The early results are promising.", "She is a promising young athlete."], "part_of_speech": "adjective"},
    {"word": "significantly", "definition": "in a sufficiently great or important way", "translation": "بشكل ملحوظ", "synonyms": ["considerably", "notably", "substantially"], "examples": ["Profits have significantly increased.", "This significantly changes the situation."], "part_of_speech": "adverb"},
    {"word": "innovative", "definition": "featuring new methods or ideas; advanced and original", "translation": "مبتكر", "synonyms": ["original", "creative", "inventive"], "examples": ["The company is known for its innovative products.", "She proposed an innovative solution."], "part_of_speech": "adjective"},
    {"word": "combines", "definition": "joins or mixes together to form a whole", "translation": "يجمع بين", "synonyms": ["merges", "unites", "integrates"], "examples": ["The program combines theory with practice.", "This recipe combines many flavors."], "part_of_speech": "verb"},
    {"word": "restore", "definition": "bring back to a former condition or state", "translation": "يستعيد / يعيد", "synonyms": ["recover", "revive", "reinstate"], "examples": ["The surgery restored his vision.", "They worked to restore the old building."], "part_of_speech": "verb"},
    {"word": "remarkable", "definition": "worthy of attention; extraordinary", "translation": "رائع / مميز", "synonyms": ["extraordinary", "striking", "impressive"], "examples": ["She showed remarkable courage.", "It was a remarkable achievement."], "part_of_speech": "adjective"},
    {"word": "experiencing", "definition": "going through or living through an event or feeling", "translation": "يختبر / يمر بـ", "synonyms": ["undergoing", "encountering", "facing"], "examples": ["Patients are experiencing improvements.", "The country is experiencing rapid growth."], "part_of_speech": "verb"},
    {"word": "substantial", "definition": "of considerable importance or size", "translation": "كبير / جوهري", "synonyms": ["considerable", "significant", "sizeable"], "examples": ["They achieved substantial progress.", "There was a substantial increase in sales."], "part_of_speech": "adjective"},
    {"word": "optimistic", "definition": "hopeful and confident about the future", "translation": "متفائل", "synonyms": ["hopeful", "positive", "confident"], "examples": ["She is optimistic about the outcome.", "The outlook for the economy is optimistic."], "part_of_speech": "adjective"},
    {"word": "revolutionize", "definition": "change something fundamentally", "translation": "يحدث ثورة في", "synonyms": ["transform", "dramatically change", "overhaul"], "examples": ["This technology could revolutionize healthcare.", "The internet revolutionized communication."], "part_of_speech": "verb"}
  ]$$,
  $${
    "id": "quiz_seed_7",
    "article_id": "seed_7",
    "questions": [
      {"question": "What kind of treatment have scientists developed?", "options": ["a treatment for colds", "a promising new treatment for Type 1 diabetes", "a treatment for broken bones", "a treatment for headaches"], "correct_index": 1},
      {"question": "What does 'promising' mean?", "options": ["showing great potential", "certain to fail", "dangerous", "very expensive"], "correct_index": 0},
      {"question": "What two technologies does the approach combine?", "options": ["surgery and medication", "immunotherapy and stem cell technology", "diet and exercise", "lasers and radiation"], "correct_index": 1},
      {"question": "What does 'restore' mean?", "options": ["remove", "damage", "bring back to a former condition", "replace"], "correct_index": 2},
      {"question": "How do researchers feel about the treatment's potential?", "options": ["pessimistic", "optimistic", "neutral", "indifferent"], "correct_index": 1}
    ]
  }$$
);

-- =============================================================
-- Article 8: Stock Markets (business, B2)
-- =============================================================
INSERT INTO articles (id, title, description, content, category, source, level, published_at, tags, vocabulary, quiz)
VALUES (
  'seed_8',
  'الأسواق المالية تسجل أعلى مستوياتها في 2026',
  'مؤشرات الأسهم العالمية تحقق أرقاماً قياسية جديدة بدعم من التكنولوجيا.',
  'Global stock markets have <highlight>surged</highlight> to record highs in 2026, driven by <highlight>exceptional</highlight> performance in the technology sector. Investors are <highlight>increasingly</highlight> <highlight>optimistic</highlight> about the economic outlook, with <highlight>substantial</highlight> gains across major indices.\n\nMarket analysts <highlight>attribute</highlight> the rally to several factors, including <highlight>strong</highlight> corporate earnings and <highlight>favourable</highlight> monetary policy. The <highlight>momentum</highlight> is expected to <highlight>continue</highlight> as <highlight>emerging</highlight> technologies create new investment opportunities.',
  'business',
  'Financial Times',
  'B2',
  NOW() - INTERVAL '1 day',
  ARRAY['markets', 'stocks', 'technology', 'economy'],
  $$[
    {"word": "surged", "definition": "increased suddenly and powerfully", "translation": "ارتفع بشكل حاد", "synonyms": ["soared", "jumped", "skyrocketed"], "examples": ["Stock prices surged after the announcement.", "Demand has surged in recent months."], "part_of_speech": "verb"},
    {"word": "exceptional", "definition": "unusually good; outstanding", "translation": "استثنائي", "synonyms": ["extraordinary", "remarkable", "unparalleled"], "examples": ["The company reported exceptional results.", "She showed exceptional talent."], "part_of_speech": "adjective"},
    {"word": "increasingly", "definition": "more and more; to an increasing degree", "translation": "بشكل متزايد", "synonyms": ["progressively", "growing", "steadily"], "examples": ["The situation is becoming increasingly complex.", "More people are increasingly using mobile payments."], "part_of_speech": "adverb"},
    {"word": "optimistic", "definition": "hopeful and confident about the future", "translation": "متفائل", "synonyms": ["hopeful", "positive", "upbeat"], "examples": ["Investors are optimistic about the market.", "She remains optimistic despite challenges."], "part_of_speech": "adjective"},
    {"word": "substantial", "definition": "of considerable importance or size", "translation": "كبير / جوهري", "synonyms": ["considerable", "significant", "sizeable"], "examples": ["They made substantial gains this quarter.", "There was a substantial increase in revenue."], "part_of_speech": "adjective"},
    {"word": "attribute", "definition": "regard something as being caused by", "translation": "يعزو إلى / ينسب", "synonyms": ["credit", "ascribe", "assign"], "examples": ["They attribute the success to hard work.", "The doctor attributed his recovery to the treatment."], "part_of_speech": "verb"},
    {"word": "strong", "definition": "powerful and robust in performance or effect", "translation": "قوي", "synonyms": ["robust", "solid", "powerful"], "examples": ["The company reported strong earnings.", "There is strong demand for the product."], "part_of_speech": "adjective"},
    {"word": "favourable", "definition": "helpful, advantageous, or positive", "translation": "موات / مناسب", "synonyms": ["advantageous", "beneficial", "positive"], "examples": ["The market conditions are favourable.", "They received a favourable response."], "part_of_speech": "adjective"},
    {"word": "momentum", "definition": "the force gained by movement or progress over time", "translation": "زخم / قوة دافعة", "synonyms": ["impetus", "drive", "momentum"], "examples": ["The campaign is gaining momentum.", "The business has strong momentum."], "part_of_speech": "noun"},
    {"word": "continue", "definition": "persist in an activity or process", "translation": "يستمر", "synonyms": ["persist", "carry on", "proceed"], "examples": ["The trend is expected to continue.", "She continues to lead the team."], "part_of_speech": "verb"},
    {"word": "emerging", "definition": "newly developed or just becoming noticeable", "translation": "ناشئ", "synonyms": ["developing", "growing", "rising"], "examples": ["Emerging markets offer new opportunities.", "Emerging technologies drive innovation."], "part_of_speech": "adjective"}
  ]$$,
  $${
    "id": "quiz_seed_8",
    "article_id": "seed_8",
    "questions": [
      {"question": "What have global stock markets done in 2026?", "options": ["crashed", "surged to record highs", "remained stable", "slightly declined"], "correct_index": 1},
      {"question": "What does 'surged' mean?", "options": ["decreased slowly", "stayed the same", "increased suddenly", "disappeared"], "correct_index": 2},
      {"question": "Which sector drove the exceptional performance?", "options": ["healthcare", "energy", "technology", "real estate"], "correct_index": 2},
      {"question": "What does 'attribute' mean in this context?", "options": ["to buy something", "to consider as caused by", "to sell shares", "to ignore"], "correct_index": 1},
      {"question": "What is expected to continue creating investment opportunities?", "options": ["old industries", "emerging technologies", "government regulations", "traditional banking"], "correct_index": 1}
    ]
  }$$
);
