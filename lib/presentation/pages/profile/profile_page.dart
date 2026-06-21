import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/usecases/get_user_progress.dart';
import 'package:newslingo/core/localization/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProgress? _progress;
  Map<String, dynamic>? _profile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      final results = await Future.wait([
        sl<GetUserProgress>().call(),
        sl<AuthRemoteDataSource>().getProfile(),
      ]);
      if (!mounted) return;
      setState(() {
        _progress = results[0] as UserProgress;
        _profile = results[1] as Map<String, dynamic>?;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _isLoading = false; _errorMessage = e.toString(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    if (_isLoading) {
      return Scaffold(
        body: Container(
          color: AppColors.background,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Container(
          color: AppColors.background,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('😕', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: AppSpacing.xl),
                    Text(_errorMessage!, style: AppTypography.bodyMedium),
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton.icon(
                      onPressed: _loadData,
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      label: Text(t.homeRetry),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _Header(
                  progress: _progress,
                  profile: _profile,
                  onEditProfile: () async {
                    final result = await context.push<bool>('/edit-profile');
                    if (result == true && mounted) _loadData();
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                _StatsRow(progress: _progress),
                const SizedBox(height: AppSpacing.xxl),
                const _MenuSection(),
                const SizedBox(height: AppSpacing.xl4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final UserProgress? progress;
  final Map<String, dynamic>? profile;
  final VoidCallback? onEditProfile;
  const _Header({this.progress, this.profile, this.onEditProfile});

  Color _levelColor(String? level) {
    if (level == null) return AppColors.levelB1;
    final base = level.split(' - ').first;
    switch (base) {
      case 'A1': return AppColors.levelA1;
      case 'A2': return AppColors.levelA2;
      case 'B1': return AppColors.levelB1;
      case 'B2': return AppColors.levelB2;
      case 'C1': return AppColors.levelC1;
      case 'C2': return AppColors.levelC1;
      default: return AppColors.levelB1;
    }
  }

  String _levelEmoji(String? level) {
    if (level == null) return '🟡';
    final base = level.split(' - ').first;
    switch (base) {
      case 'A1': return '🟢';
      case 'A2': return '🟢';
      case 'B1': return '🟡';
      case 'B2': return '🟠';
      case 'C1': return '🔴';
      case 'C2': return '🔴';
      default: return '🟡';
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final name = profile?['name'] as String? ?? t.profileDefaultName;
    final email = profile?['email'] as String? ?? '';
    final level = profile?['level'] as String? ?? t.profileDefaultLevel;
    final accentColor = _levelColor(level);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl, AppSpacing.xxl, AppSpacing.xl, 0,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Center(
                  child: Text('🦉', style: TextStyle(fontSize: 48)),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -4,
                child: GestureDetector(
                  onTap: onEditProfile,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(Icons.edit_rounded, size: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            name,
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_levelEmoji(level), style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  level,
                  style: AppTypography.labelLarge.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (email.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              email,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final UserProgress? progress;
  const _StatsRow({this.progress});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(emoji: '🔥', value: '${progress?.streak ?? 0}', label: t.profileStatStreak),
            _StatItem(emoji: '📰', value: '${progress?.articlesRead ?? 0}', label: t.profileStatArticles),
            _StatItem(emoji: '📝', value: '${progress?.wordsLearned ?? 0}', label: t.profileStatWords),
            _StatItem(emoji: '✅', value: '${progress?.quizzesPassed ?? 0}', label: t.profileStatQuizzes),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const _StatItem({required this.emoji, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final items = [
      _MenuItem('🔖', t.profileSavedArticles, '/saved-articles'),
      _MenuItem('🏆', t.profileAchievements, '/achievements'),
      _MenuItem('📊', t.profileDashboard, '/dashboard'),
      _MenuItem('⚙️', t.profileSettings, '/settings'),
      _MenuItem('⭐', t.profileSubscription, '/subscription'),
      _MenuItem('❓', t.profileHelp, '/help'),
      _MenuItem('📝', t.profileAbout, '/about'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        children: [
          ...items.map((item) => _MenuTile(item: item)),
          const SizedBox(height: AppSpacing.xl),
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
            ),
            child: TextButton(
              onPressed: () async {
                await sl<AuthRemoteDataSource>().signOut();
                if (context.mounted) context.go('/login');
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🚪', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: AppSpacing.sm),
                  Text(t.settingsLogout),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String emoji;
  final String label;
  final String? route;
  const _MenuItem(this.emoji, this.label, this.route);
}

class _MenuTile extends StatelessWidget {
  final _MenuItem item;
  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.route != null ? () => context.push(item.route!) : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.md + 2,
            ),
            child: Row(
              children: [
                Text(item.emoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    item.label,
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_left_rounded, color: AppColors.textTertiary, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
