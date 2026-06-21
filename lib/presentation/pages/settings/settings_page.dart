import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/localization/locale_cubit.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _dailyNews = true;
  bool _vocabReminder = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await sl<AuthRemoteDataSource>().getSettings();
    if (settings != null && mounted) {
      setState(() {
        _notifications = settings['notifications_enabled'] as bool? ?? true;
        _dailyNews = settings['daily_reminder'] as bool? ?? false;
        _vocabReminder = false;
        final timeStr = settings['reminder_time'] as String? ?? '09:00';
        final parts = timeStr.split(':');
        _reminderTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 9,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      });
    }
  }

  Future<void> _saveSettings() async {
    await sl<AuthRemoteDataSource>().updateSettings({
      'notifications_enabled': _notifications,
      'daily_reminder': _dailyNews,
      'reminder_time':
          '${_reminderTime.hour.toString().padLeft(2, '0')}:${_reminderTime.minute.toString().padLeft(2, '0')}',
    });
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
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Row(
                  children: [
                    AppBackButton(),
                    const Spacer(),
                    Text(
                      '⚙️ ${t.settingsTitle}',
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  children: [
                    _Group(title: t.settingsApp, items: [
                      _SettingsTile(
                        emoji: '🌐',
                        title: t.settingsLanguage,
                        subtitle: t.settingsArabic,
                        trailing: _buildLangBadge(),
                        onTap: () => context.push('/language-settings'),
                      ),
                    ]),
                    _Group(title: t.settingsNotifications, items: [
                      _SwitchTile(emoji: '🔔', title: t.settingsNotifTitle, subtitle: t.settingsNotifSub, value: _notifications, onChanged: (v) { setState(() => _notifications = v); _saveSettings(); }),
                      _SwitchTile(emoji: '📰', title: t.settingsDailyNewsTitle, subtitle: t.settingsDailyNewsSub, value: _dailyNews, onChanged: (v) { setState(() => _dailyNews = v); _saveSettings(); }),
                      _SwitchTile(emoji: '📝', title: t.settingsVocabRemindTitle, subtitle: t.settingsVocabRemindSub, value: _vocabReminder, onChanged: (v) { setState(() => _vocabReminder = v); _saveSettings(); }),
                      _SettingsTile(
                        emoji: '⏰',
                        title: t.settingsRemindTime,
                        subtitle: _reminderTime.format(context),
                        onTap: _pickTime,
                      ),
                    ]),
                    _Group(title: t.settingsAccount, items: [
                      _SettingsTile(
                        emoji: '👤',
                        title: t.settingsProfileTitle,
                        subtitle: t.settingsProfileSub,
                        onTap: () => context.push('/edit-profile'),
                      ),
                      _SettingsTile(
                        emoji: '⭐',
                        title: t.settingsSubscription,
                        subtitle: t.settingsSubscriptionSub,
                        onTap: () => context.push('/subscription'),
                      ),
                    ]),
                    _Group(title: t.settingsSupport, items: [
                      _SettingsTile(
                        emoji: '🎧',
                        title: t.settingsHelp,
                        onTap: () => context.push('/help'),
                      ),
                      _SettingsTile(
                        emoji: 'ℹ️',
                        title: t.settingsAbout,
                        subtitle: 'NewsLingo v1.0.0',
                        onTap: () => context.push('/about'),
                      ),
                      _SettingsTile(
                        emoji: '🔒',
                        title: t.settingsPrivacy,
                        onTap: () => context.push('/privacy'),
                      ),
                      _SettingsTile(
                        emoji: '📄',
                        title: t.settingsTerms,
                        onTap: () => context.push('/terms'),
                      ),
                    ]),
                    const SizedBox(height: AppSpacing.xl),
                    _DangerSection(onLogout: _onLogout, onDeleteAccount: _onDeleteAccount),
                    const SizedBox(height: AppSpacing.xl4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLangBadge() {
    final code = context.watch<LocaleCubit>().state.languageCode;
    final langMap = <String, String>{
      'ar': '🇸🇦',
      'en': '🇬🇧',
      'es': '🇪🇸',
      'fr': '🇫🇷',
      'pt': '🇧🇷',
      'ru': '🇷🇺',
      'hi': '🇮🇳',
      'zh': '🇨🇳',
    };
    final nameMap = <String, String Function(AppLocalizations)>{
      'ar': (t) => t.settingsArabic,
      'en': (_) => 'English',
      'es': (_) => 'Español',
      'fr': (_) => 'Français',
      'pt': (_) => 'Português',
      'ru': (_) => 'Русский',
      'hi': (_) => 'हिन्दी',
      'zh': (_) => '中文',
    };
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(langMap[code] ?? '🌐', style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            nameMap[code]?.call(t) ?? code,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (time != null && mounted) { setState(() => _reminderTime = time); _saveSettings(); }
  }

  Future<void> _onLogout() async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        title: Text('🚪 ${t.settingsLogout}'),
        content: Text(t.settingsLogoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(t.settingsLogout),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await sl<AuthRemoteDataSource>().signOut();
      if (mounted) context.go('/login');
    }
  }

  Future<void> _onDeleteAccount() async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        title: Text('🗑️ ${t.settingsDeleteAccount}'),
        content: Text(t.settingsDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(t.settingsDeleteAccount),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await sl<AuthRemoteDataSource>().deleteAccount();
        if (mounted) context.go('/onboarding');
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.settingsDeleteError),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}

class _Group extends StatelessWidget {
  final String title;
  final List<Widget> items;
  const _Group({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.md),
          ...items,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.emoji, required this.title, this.subtitle, this.trailing, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(subtitle!, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ],
                  ),
                ),
                trailing ?? Icon(Icons.chevron_left_rounded, color: AppColors.textTertiary, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({required this.emoji, required this.title, required this.subtitle, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                  Text(subtitle, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DangerSection extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  const _DangerSection({
    required this.onLogout,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onLogout,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: const Center(child: Text('🚪', style: TextStyle(fontSize: 18))),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      t.settingsLogout,
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onDeleteAccount,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: const Center(child: Text('🗑️', style: TextStyle(fontSize: 18))),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      t.settingsDeleteAccount,
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
