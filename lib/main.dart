import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newslingo/core/constants/app_constants.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/localization/locale_cubit.dart';
import 'package:newslingo/core/responsive/responsive_config.dart';
import 'package:newslingo/core/router/app_router.dart';
import 'package:newslingo/core/theme/app_theme.dart';
import 'package:newslingo/presentation/cubit/news/news_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();

  // One-time migration: clear all Supabase sessions from SharedPreferences (Android)
  // to remove stale session from old project 'xtjobjsplnfisjhjyjpo'
  try {
    const storage = FlutterSecureStorage();
    final migrated = await storage.read(key: 'migrated_old_session');
    if (migrated == null) {
      final prefs = await SharedPreferences.getInstance();
      final keysToRemove = prefs.getKeys().where((k) => k.startsWith('sb-')).toList();
      for (final key in keysToRemove) {
        await prefs.remove(key);
      }
      await storage.write(key: 'migrated_old_session', value: '1');
    }
  } catch (_) {}

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    publishableKey: AppConstants.supabaseAnonKey,
  );

  await initDependencies();
  await sl<LocaleCubit>().loadLocale();
  runApp(const NewsLingoApp());
}

class NewsLingoApp extends StatelessWidget {
  const NewsLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          final cubit = sl<NewsCubit>();
          final locale = sl<LocaleCubit>().state.languageCode;
          try {
            cubit.loadArticles(locale: locale);
          } catch (_) {}
          return cubit;
        }),
        BlocProvider.value(value: sl<LocaleCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(
          Breakpoints.designWidth,
          Breakpoints.designHeight,
        ),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => BlocListener<LocaleCubit, Locale>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, locale) => appRouter.refresh(),
          child: BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
            return MaterialApp.router(
              title: 'NewsLingo',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(languageCode: locale.languageCode),
              routerConfig: appRouter,
              locale: locale,
              supportedLocales: const [
                Locale('ar'),
                Locale('en'),
                Locale('es'),
                Locale('fr'),
                Locale('pt'),
                Locale('ru'),
                Locale('hi'),
                Locale('zh'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        ),
      ),
    ),
  );
}
}
