class AppConstants {
  AppConstants._();

  static const String appName = 'News & Languages';

  static const String supabaseUrl = 'https://qwxsntvobtfjldurswfq.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF3eHNudHZvYnRmamxkdXJzd2ZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwMzE3NTksImV4cCI6MjA5NzYwNzc1OX0.GqMP18zg-LcTQnj9zmxacJyglSGXAtxiqt2N30O8Idg';

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
