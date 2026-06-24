class AppConstants {
  AppConstants._();

  static const String appName = 'News & Languages';

  static const String supabaseUrl = 'https://qwxsntvobtfjldurswfq.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_agjOVyl9XwitJAsp27ciEA_HGui07GL';

  static const Duration newsCacheDuration = Duration(hours: 1);
  static const int maxDailyArticles = 10;
  static const int streakGoalDays = 7;

  static const List<String> categories = [
    'general',
    'sports',
    'technology',
    'business',
    'science',
    'entertainment',
  ];
}
