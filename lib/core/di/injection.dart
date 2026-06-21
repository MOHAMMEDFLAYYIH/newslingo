import 'package:get_it/get_it.dart';
import 'package:newslingo/core/localization/locale_cubit.dart';
import 'package:newslingo/core/services/deepl_service.dart';
import 'package:newslingo/data/datasources/local/article_translation_cache.dart';
import 'package:newslingo/data/datasources/local/news_local_datasource.dart';
import 'package:newslingo/data/datasources/local/user_local_datasource.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/data/datasources/remote/news_remote_datasource.dart';
import 'package:newslingo/data/repositories/news_repository_impl.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';
import 'package:newslingo/domain/usecases/get_article_details.dart';
import 'package:newslingo/domain/usecases/get_articles.dart';
import 'package:newslingo/domain/usecases/get_user_progress.dart';
import 'package:newslingo/domain/usecases/get_word_definitions.dart';
import 'package:newslingo/domain/usecases/manage_vocabulary.dart';
import 'package:newslingo/presentation/cubit/news/news_cubit.dart';
import 'package:newslingo/presentation/cubit/progress/progress_cubit.dart';
import 'package:newslingo/presentation/cubit/word/word_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = Supabase.instance.client;
  sl.registerLazySingleton<SupabaseClient>(() => supabase);

  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSource(),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(),
  );
  sl.registerLazySingleton<ArticleTranslationCache>(
    () => ArticleTranslationCache(),
  );

  sl.registerLazySingleton<DeepLService>(
    () => DeepLService(),
  );

  sl.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(sl()),
  );

  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      authRemoteDataSource: sl(),
      deepLService: sl(),
      translationCache: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetArticles(sl()));
  sl.registerLazySingleton(() => ManageVocabulary(sl()));
  sl.registerLazySingleton(() => GetArticleDetails(sl()));
  sl.registerLazySingleton(() => GetWordDefinitions(sl()));
  sl.registerLazySingleton(() => GetUserProgress(sl()));
  sl.registerLazySingleton(() => UpdateUserProgress(sl()));

  sl.registerFactory(() => NewsCubit(sl()));
  sl.registerFactory(() => WordCubit(sl()));
  sl.registerFactory(() => ProgressCubit(sl(), sl()));
}
