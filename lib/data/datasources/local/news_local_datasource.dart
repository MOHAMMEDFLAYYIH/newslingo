import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:newslingo/data/models/article_model.dart';
import 'package:newslingo/domain/entities/article.dart';

class NewsLocalDataSource {
  static const String _articlesBox = 'articles';
  static const String _wordsBox = 'saved_words';
  static const String _progressBox = 'user_progress';
  static const String _bookmarksBox = 'bookmarked_articles';

  Future<List<ArticleModel>> getCachedArticles({
    String? category,
    int page = 1,
  }) async {
    final box = await Hive.openBox<String>(_articlesBox);
    if (box.isEmpty) {
      await _seedArticles(box);
    }
    final keys = box.keys.toList();

    List<ArticleModel> articles = [];
    for (final key in keys) {
      final data = box.get(key);
      if (data != null) {
        final model = ArticleModel.fromJson(
          jsonDecode(data) as Map<String, dynamic>,
        );
        if (category == null || model.category == category) {
          articles.add(model);
        }
      }
    }

    articles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return articles;
  }

  Future<void> _seedArticles(Box<String> box) async {
    final now = DateTime.now();
    final seeds = [
      ArticleModel(
        id: 'seed_1',
        title: 'علماء يكتشفون طريقة جديدة لتوليد الطاقة النظيفة',
        description:
            'اكتشاف علمي رائد يكشف عن طريقة جديدة لتوليد الطاقة النظيفة باستخدام تقنية الاندماج النووي.',
        content:
            'A groundbreaking scientific discovery has revealed a new method for generating clean energy that could revolutionize the <highlight>sustainable</highlight> power industry. Researchers at the Global Energy Institute announced a <highlight>significant</highlight> <highlight>breakthrough</highlight> in fusion technology that promises unlimited clean energy.\n\nThe new approach, which has been in development for over a decade, uses advanced magnetic fields to contain plasma at extremely high temperatures. This <highlight>comprehensive</highlight> method addresses many of the challenges that have previously prevented <highlight>widespread</highlight> adoption of fusion power.\n\n<highlight>Despite</highlight> earlier skepticism from some experts, the team was able to <highlight>implement</highlight> a novel cooling system that maintains stability for longer periods. <highlight>Consequently</highlight>, the reactor can now operate <highlight>sustainably</highlight> for extended durations, marking a major step toward commercial viability.\n\nThe <highlight>emerging</highlight> technology has attracted attention from governments and private investors worldwide.',
        category: 'technology',
        source: 'Science Daily',
        imageUrl: '',
        audioUrl: '',
        level: 'B2',
        publishedAt: now.subtract(const Duration(hours: 3)),
        tags: ['energy', 'science', 'fusion', 'clean-energy'],
      ),
      ArticleModel(
        id: 'seed_2',
        title: 'منتخب المغرب يحقق فوزاً تاريخياً في كأس العالم',
        description:
            'المنتخب المغربي يسجل إنجازاً غير مسبوق بوصوله إلى نصف نهائي كأس العالم.',
        content:
            'In a stunning turn of events, the Moroccan national team has <highlight>secured</highlight> a historic victory that has sent shockwaves through the football world. The team\'s <highlight>remarkable</highlight> journey to the World Cup semi-finals represents a <highlight>significant</highlight> achievement for African football.\n\nThe squad, led by an <highlight>exceptional</highlight> coaching staff, demonstrated <highlight>outstanding</highlight> teamwork and <highlight>resilience</highlight> throughout the tournament. Their <highlight>impressive</highlight> performance has <highlight>inspired</highlight> millions around the globe.',
        category: 'sports',
        source: 'BBC Sport',
        imageUrl: '',
        audioUrl: '',
        level: 'B1',
        publishedAt: now.subtract(const Duration(hours: 5)),
        tags: ['football', 'world-cup', 'morocco', 'history'],
      ),
      ArticleModel(
        id: 'seed_3',
        title: 'الذكاء الاصطناعي يحدث ثورة في مجال التعليم',
        description:
            'تقنيات الذكاء الاصطناعي التوليدي تغير طريقة تعلم الطلاب حول العالم.',
        content:
            'Artificial intelligence is <highlight>transforming</highlight> education in ways that were once <highlight>unimaginable</highlight>. From personalized learning paths to <highlight>intelligent</highlight> tutoring systems, AI is making education more <highlight>accessible</highlight> and <highlight>effective</highlight> than ever before.\n\nEducators are <highlight>embracing</highlight> these new tools to create <highlight>engaging</highlight> learning experiences that adapt to each student\'s needs. The <highlight>potential</highlight> for AI to <highlight>revolutionize</highlight> education is <highlight>enormous</highlight>, particularly in developing regions where access to quality teachers is limited.',
        category: 'technology',
        source: 'TechCrunch',
        imageUrl: '',
        audioUrl: '',
        level: 'B2',
        publishedAt: now.subtract(const Duration(hours: 8)),
        tags: ['ai', 'education', 'technology', 'learning'],
      ),
      ArticleModel(
        id: 'seed_4',
        title: 'شركة أبل تطلق هاتفها الجديد بتقنية ثورية',
        description: 'أبل تعلن عن أحدث إصداراتها مع ميزات ذكاء اصطناعي متقدمة.',
        content:
            'Apple has <highlight>unveiled</highlight> its latest smartphone featuring <highlight>groundbreaking</highlight> AI capabilities. The new device <highlight>incorporates</highlight> advanced machine learning processors that enable <highlight>sophisticated</highlight> features never before seen in a smartphone.\n\nThe company\'s CEO described the launch as a <highlight>significant</highlight> milestone, emphasizing how the new technology will <highlight>enhance</highlight> user experience. Industry analysts have <highlight>praised</highlight> the innovation, predicting it will <highlight>influence</highlight> the entire smartphone market.',
        category: 'technology',
        source: 'The Verge',
        imageUrl: '',
        audioUrl: '',
        level: 'B1',
        publishedAt: now.subtract(const Duration(hours: 12)),
        tags: ['apple', 'iphone', 'ai', 'smartphone'],
      ),
      ArticleModel(
        id: 'seed_5',
        title: 'تغير المناخ: قمة عالمية تتفق على خفض الانبعاثات',
        description:
            'قادة العالم يتوصلون إلى اتفاق تاريخي لتقليل انبعاثات الكربون.',
        content:
            'World leaders have <highlight>reached</highlight> a historic agreement to <highlight>dramatically</highlight> reduce carbon emissions over the next decade. The <highlight>ambitious</highlight> plan <highlight>commits</highlight> signatory nations to <highlight>substantial</highlight> cuts in greenhouse gas emissions, marking a <highlight>crucial</highlight> step in the fight against climate change.\n\nEnvironmental experts have <highlight>welcomed</highlight> the agreement but <highlight>emphasize</highlight> the need for <highlight>immediate</highlight> action. The <highlight>implementation</highlight> of these measures will require <highlight>unprecedented</highlight> cooperation between nations.',
        category: 'science',
        source: 'Reuters',
        imageUrl: '',
        audioUrl: '',
        level: 'B2',
        publishedAt: now.subtract(const Duration(hours: 24)),
        tags: ['climate', 'environment', 'emissions', 'global'],
      ),
      ArticleModel(
        id: 'seed_6',
        title: 'انطلاق مهرجان كان السينمائي بنجوم هوليوود',
        description:
            'نجوم السينما العالمية يتألقون على السجادة الحمراء في مهرجان كان.',
        content:
            'The Cannes Film Festival has <highlight>officially</highlight> opened with a star-studded red carpet ceremony. This year\'s festival <highlight>showcases</highlight> an <highlight>impressive</highlight> lineup of films from around the world, <highlight>highlighting</highlight> the best of <highlight>contemporary</highlight> cinema.\n\nCritics have <highlight>praised</highlight> the diversity of this year\'s selection, which <highlight>includes</highlight> several <highlight>groundbreaking</highlight> works from emerging directors. The festival <highlight>continues</highlight> to be a <highlight>vital</highlight> platform for <highlight>celebrating</highlight> cinematic excellence.',
        category: 'entertainment',
        source: 'Variety',
        imageUrl: '',
        audioUrl: '',
        level: 'B1',
        publishedAt: now.subtract(const Duration(hours: 48)),
        tags: ['cannes', 'film', 'festival', 'cinema'],
      ),
      ArticleModel(
        id: 'seed_7',
        title: 'اكتشاف علاج جديد لمرض السكري',
        description: 'باحثون يطورون علاجاً مبتكراً لمرض السكري من النوع الأول.',
        content:
            'Scientists have <highlight>developed</highlight> a <highlight>promising</highlight> new treatment for Type 1 diabetes that could <highlight>significantly</highlight> improve the lives of millions. The <highlight>innovative</highlight> approach <highlight>combines</highlight> immunotherapy with stem cell technology to <highlight>restore</highlight> insulin production.\n\nClinical trials have shown <highlight>remarkable</highlight> results, with patients <highlight>experiencing</highlight> <highlight>substantial</highlight> improvements in blood sugar control. Researchers are <highlight>optimistic</highlight> about the treatment\'s potential to <highlight>revolutionize</highlight> diabetes management.',
        category: 'science',
        source: 'Nature Medicine',
        imageUrl: '',
        audioUrl: '',
        level: 'C1',
        publishedAt: now.subtract(const Duration(days: 2)),
        tags: ['diabetes', 'treatment', 'stem-cells', 'health'],
      ),
      ArticleModel(
        id: 'seed_8',
        title: 'الأسواق المالية تسجل أعلى مستوياتها في 2026',
        description:
            'مؤشرات الأسهم العالمية تحقق أرقاماً قياسية جديدة بدعم من التكنولوجيا.',
        content:
            'Global stock markets have <highlight>surged</highlight> to record highs in 2026, driven by <highlight>exceptional</highlight> performance in the technology sector. Investors are <highlight>increasingly</highlight> <highlight>optimistic</highlight> about the economic outlook, with <highlight>substantial</highlight> gains across major indices.\n\nMarket analysts <highlight>attribute</highlight> the rally to several factors, including <highlight>strong</highlight> corporate earnings and <highlight>favourable</highlight> monetary policy. The <highlight>momentum</highlight> is expected to <highlight>continue</highlight> as <highlight>emerging</highlight> technologies create new investment opportunities.',
        category: 'business',
        source: 'Financial Times',
        imageUrl: '',
        audioUrl: '',
        level: 'B2',
        publishedAt: now.subtract(const Duration(days: 1)),
        tags: ['markets', 'stocks', 'technology', 'economy'],
      ),
    ];
    for (final article in seeds) {
      await box.put(article.id, jsonEncode(article.toJson()));
    }
  }

  Future<void> cacheArticles(List<ArticleModel> articles) async {
    final box = await Hive.openBox<String>(_articlesBox);
    for (final article in articles) {
      await box.put(article.id, jsonEncode(article.toJson()));
    }
  }

  Future<ArticleModel?> getCachedArticle(String id) async {
    final box = await Hive.openBox<String>(_articlesBox);
    if (box.isEmpty) {
      await _seedArticles(box);
    }
    final data = box.get(id);
    if (data == null) return null;
    return ArticleModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  Future<void> deleteWord(String word) async {
    final box = await Hive.openBox<String>(_wordsBox);
    await box.delete(word);
  }

  Future<void> saveWord(SavedWord word) async {
    final box = await Hive.openBox<String>(_wordsBox);
    await box.put(
      word.word,
      jsonEncode({
        'word': word.word,
        'definition': word.definition,
        'translation': word.translation,
        'article_id': word.articleId,
        'saved_at': word.savedAt.toIso8601String(),
        'review_count': word.reviewCount,
        'next_review_date': word.nextReviewDate?.toIso8601String(),
      }),
    );
  }

  Future<List<SavedWord>> getSavedWords() async {
    final box = await Hive.openBox<String>(_wordsBox);
    final words = <SavedWord>[];
    for (final key in box.keys) {
      final data = box.get(key);
      if (data != null) {
        final json = jsonDecode(data) as Map<String, dynamic>;
        try {
          words.add(
            SavedWord(
              word: json['word'] as String? ?? '',
              definition: json['definition'] as String? ?? '',
              translation: json['translation'] as String? ?? '',
              articleId: json['article_id'] as String? ?? '',
              savedAt: json['saved_at'] != null
                  ? DateTime.parse(json['saved_at'] as String)
                  : DateTime.now(),
              reviewCount: json['review_count'] as int? ?? 0,
              nextReviewDate: json['next_review_date'] != null
                  ? DateTime.parse(json['next_review_date'] as String)
                  : null,
            ),
          );
        } catch (_) {
          continue;
        }
      }
    }
    return words;
  }

  Future<void> updateWordReview(SavedWord word) async {
    final box = await Hive.openBox<String>(_wordsBox);
    final existingData = box.get(word.word);
    if (existingData != null) {
      final json = jsonDecode(existingData) as Map<String, dynamic>;
      json['review_count'] = word.reviewCount;
      json['next_review_date'] = word.nextReviewDate?.toIso8601String();
      await box.put(word.word, jsonEncode(json));
    }
  }

  Future<void> saveProgress(Map<String, dynamic> progress) async {
    final box = await Hive.openBox<String>(_progressBox);
    await box.put('progress', jsonEncode(progress));
  }

  Future<Map<String, dynamic>?> getProgress() async {
    final box = await Hive.openBox<String>(_progressBox);
    final data = box.get('progress');
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> bookmarkArticle(String articleId) async {
    final box = await Hive.openBox<bool>(_bookmarksBox);
    await box.put(articleId, true);
  }

  Future<void> unbookmarkArticle(String articleId) async {
    final box = await Hive.openBox<bool>(_bookmarksBox);
    await box.delete(articleId);
  }

  Future<bool> isArticleBookmarked(String articleId) async {
    final box = await Hive.openBox<bool>(_bookmarksBox);
    return box.get(articleId, defaultValue: false) ?? false;
  }

  Future<List<String>> getBookmarkedArticleIds() async {
    final box = await Hive.openBox<bool>(_bookmarksBox);
    return box.keys.where((k) => box.get(k) == true).cast<String>().toList();
  }

  Future<List<ArticleModel>> getBookmarkedArticles() async {
    final ids = await getBookmarkedArticleIds();
    final articles = <ArticleModel>[];
    for (final id in ids) {
      final article = await getCachedArticle(id);
      if (article != null) articles.add(article);
    }
    return articles;
  }
}
