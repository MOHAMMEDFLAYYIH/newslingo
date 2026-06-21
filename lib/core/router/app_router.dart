import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/presentation/pages/article/article_detail_page.dart';
import 'package:newslingo/presentation/pages/auth/forgot_password_page.dart';
import 'package:newslingo/presentation/pages/auth/interest_selection_page.dart';
import 'package:newslingo/presentation/pages/auth/language_level_page.dart';
import 'package:newslingo/presentation/pages/auth/login_page.dart';
import 'package:newslingo/presentation/pages/auth/otp_verification_page.dart';
import 'package:newslingo/presentation/pages/learning/vocabulary_detail_page.dart';
import 'package:newslingo/presentation/pages/auth/sign_up_page.dart';
import 'package:newslingo/presentation/pages/home/home_page.dart';
import 'package:newslingo/presentation/pages/home/search_page.dart';
import 'package:newslingo/presentation/pages/info/about_page.dart';
import 'package:newslingo/presentation/pages/info/help_page.dart';
import 'package:newslingo/presentation/pages/info/privacy_page.dart';
import 'package:newslingo/presentation/pages/info/terms_page.dart';
import 'package:newslingo/presentation/pages/learning/flashcards_page.dart';
import 'package:newslingo/presentation/pages/learning/pronunciation_practice_page.dart';
import 'package:newslingo/presentation/pages/learning/quiz_page.dart';
import 'package:newslingo/presentation/pages/learning/quiz_results_page.dart';
import 'package:newslingo/presentation/pages/main/main_shell.dart';
import 'package:newslingo/presentation/pages/onboarding/onboarding_page.dart';
import 'package:newslingo/presentation/pages/profile/edit_profile_page.dart';
import 'package:newslingo/presentation/pages/profile/profile_page.dart';
import 'package:newslingo/presentation/pages/profile/saved_articles_page.dart';
import 'package:newslingo/presentation/pages/profile/subscription_page.dart';
import 'package:newslingo/presentation/pages/profile/payment_page.dart';
import 'package:newslingo/presentation/pages/progress/achievements_page.dart';
import 'package:newslingo/presentation/pages/progress/dashboard_page.dart';
import 'package:newslingo/presentation/pages/progress/level_up_screen.dart';
import 'package:newslingo/presentation/pages/progress/leaderboard_page.dart';
import 'package:newslingo/presentation/pages/progress/streak_page.dart';
import 'package:newslingo/presentation/pages/settings/language_settings_page.dart';
import 'package:newslingo/presentation/pages/settings/settings_page.dart';
import 'package:newslingo/presentation/pages/splash/splash_page.dart';
import 'package:newslingo/presentation/pages/vocabulary/vocabulary_page.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigator,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/onboarding/level',
      builder: (context, state) => const LanguageLevelPage(),
    ),
    GoRoute(
      path: '/onboarding/interests',
      builder: (context, state) => const InterestSelectionPage(),
    ),
    GoRoute(
      path: '/onboarding/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/otp-verification',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const OtpVerificationPage(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/saved-articles',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const SavedArticlesPage(),
    ),
    GoRoute(
      path: '/edit-profile',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: '/subscription',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const SubscriptionPage(),
    ),
    GoRoute(
      path: '/payment',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        final plan = state.extra as Map<String, dynamic>?;
        return PaymentPage(plan: plan);
      },
    ),
    GoRoute(
      path: '/about',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/help',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const HelpPage(),
    ),
    GoRoute(
      path: '/privacy',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const PrivacyPage(),
    ),
    GoRoute(
      path: '/terms',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: '/language-settings',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const LanguageSettingsPage(),
    ),
    GoRoute(
      path: '/notification-preferences',
      parentNavigatorKey: _rootNavigator,
      redirect: (context, state) => '/settings',
    ),
    GoRoute(
      path: '/article/:id',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ArticleDetailPage(articleId: id);
      },
    ),
    GoRoute(
      path: '/vocabulary/:word',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        final word = state.pathParameters['word']!;
        return VocabularyDetailPage(word: word);
      },
    ),
    GoRoute(
      path: '/flashcards',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const FlashcardsPage(),
    ),
    GoRoute(
      path: '/quiz/:articleId',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        final articleId = state.pathParameters['articleId']!;
        return QuizPage(articleId: articleId);
      },
    ),
    GoRoute(
      path: '/quiz-results',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const QuizResultsPage(),
    ),
    GoRoute(
      path: '/streak',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const StreakPage(),
    ),
    GoRoute(
      path: '/dashboard',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/achievements',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const AchievementsPage(),
    ),
    GoRoute(
      path: '/leaderboard',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const LeaderboardPage(),
    ),
    GoRoute(
      path: '/search',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/pronunciation/:word',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        final word = state.pathParameters['word']!;
        return PronunciationPracticePage(word: word);
      },
    ),
    GoRoute(
      path: '/level-up',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) => const LevelUpScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/vocabulary',
              builder: (context, state) => const VocabularyPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
