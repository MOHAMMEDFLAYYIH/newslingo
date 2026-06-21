import 'package:flutter/material.dart';

import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  List<_UserData> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<String> _tabs(AppLocalizations t) => [t.leaderboardWeek, t.leaderboardMonth, t.leaderboardAll];

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await sl<AuthRemoteDataSource>().getLeaderboard();
      if (!mounted) return;
      final emojis = [
        '🦊', '🐯', '🐰', '🐼', '🦄', '🐨', '🦋', '🐲', '🐱', '🐶',
        '🦁', '🐸', '🐵', '🐻', '🐧',
      ];
      final profiles = data.asMap().entries.map((entry) {
        final i = entry.key;
        final row = entry.value;
        final profile = row['profiles'] as Map<String, dynamic>?;
        final t = AppLocalizations.of(context);
        final name = profile?['name'] as String? ?? t.leaderboardDefaultName;
        final streak = row['streak'] as int? ?? 0;
        final articles = row['articles_read'] as int? ?? 0;
        final words = row['words_learned'] as int? ?? 0;
        final quizzes = row['quizzes_passed'] as int? ?? 0;
        final score = streak * 5 + articles * 10 + words * 3 + quizzes * 15;
        final level = _computeLevel(score);
        return _UserData(name, emojis[i % emojis.length], score, level, i + 1);
      }).toList();
      setState(() {
        _users = profiles;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        final t = AppLocalizations.of(context);
        _errorMessage = t.leaderboardError;
      });
    }
  }

  String _computeLevel(int score) {
    if (score >= 10000) return 'C2';
    if (score >= 6000) return 'C1';
    if (score >= 3000) return 'B2';
    if (score >= 1000) return 'B1';
    if (score >= 400) return 'A2';
    return 'A1';
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Row(
                  children: [
                    AppBackButton(),
                    const Spacer(),
                    Text(
                      t.leaderboardTitle,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _TabBar(
                tabs: _tabs(t),
                selected: _selectedTab,
                onChanged: (i) => setState(() => _selectedTab = i),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? _ErrorView(
                            message: _errorMessage!,
                            onRetry: _loadLeaderboard,
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                _Podium(users: _users),
                                const SizedBox(height: AppSpacing.xl),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.xl),
                                  child: _UserList(
                                      users: _users.skip(3).toList()),
                                ),
                                const SizedBox(height: AppSpacing.xl4),
                              ],
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('😕', style: TextStyle(fontSize: 64)),
            const SizedBox(height: AppSpacing.xl),
            Text(message,
                style: AppTypography.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xxl),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(t.leaderboardRetry),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserData {
  final String name;
  final String emoji;
  final int score;
  final String level;
  final int rank;
  const _UserData(this.name, this.emoji, this.score, this.level, this.rank);
}

class _TabBar extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onChanged;
  const _TabBar({required this.tabs, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isSelected = i == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  boxShadow: isSelected ? AppColors.shadowSm : null,
                ),
                child: Text(
                  tabs[i],
                  textAlign: TextAlign.center,
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  final List<_UserData> users;
  const _Podium({required this.users});

  @override
  Widget build(BuildContext context) {
    final top3 = users.take(3).toList();
    final podiumOrder = [
      _PodiumData(2, top3.length > 1 ? top3[1] : null, 100, '🥈'),
      _PodiumData(1, top3.isNotEmpty ? top3[0] : null, 120, '🥇'),
      _PodiumData(3, top3.length > 2 ? top3[2] : null, 80, '🥉'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: SizedBox(
        height: 220,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: podiumOrder.map((p) {
            final user = p.user;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: (220 - p.height) + 20,
                  left: p.rank == 1 ? AppSpacing.xs : 0,
                  right: p.rank == 1 ? AppSpacing.xs : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        gradient: p.rank == 1
                            ? const LinearGradient(colors: [Color(0xFFFFC800), Color(0xFFFF9600)])
                            : p.rank == 2
                                ? const LinearGradient(colors: [Color(0xFFD1D5DB), Color(0xFF9CA3AF)])
                                : const LinearGradient(colors: [Color(0xFFD97706), Color(0xFFB45309)]),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        boxShadow: [
                          BoxShadow(
                            color: p.rank == 1
                                ? const Color(0xFFFFC800).withValues(alpha: 0.4)
                                : Colors.black.withValues(alpha: 0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(p.emoji, style: const TextStyle(fontSize: 30)),
                      ),
                    ),
                    if (user != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        user.name,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: p.rank == 1 ? FontWeight.w900 : FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${user.score} XP',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xs),
                    Text(p.emoji, style: const TextStyle(fontSize: 28)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PodiumData {
  final int rank;
  final _UserData? user;
  final double height;
  final String emoji;
  const _PodiumData(this.rank, this.user, this.height, this.emoji);
}

class _UserList extends StatelessWidget {
  final List<_UserData> users;
  const _UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: List.generate(users.length, (i) {
          final user = users[i];
          final isLast = i == users.length - 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: [
                SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: Text(
                          '${user.rank}',
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Center(
                          child: Text(user.emoji, style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.name,
                              style: AppTypography.titleSmall.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              t.leaderboardLevel(user.level),
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${user.score}',
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast) const Divider(height: 1, color: AppColors.outlineVariant),
              ],
            ),
          );
        }),
      ),
    );
  }
}
