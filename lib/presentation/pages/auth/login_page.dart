import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/local/user_local_datasource.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/presentation/widgets/app_text_field.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  static DateTime? _lastRateLimitHit;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.surfaceGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    child: AppBackButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.loginTitle, style: AppTypography.displayMedium),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          t.loginSubtitle,
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: _emailController,
                          label: t.emailLabel,
                          hint: 'example@email.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          isRtl: Directionality.of(context) == TextDirection.rtl,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return t.emailRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppTextField(
                          controller: _passwordController,
                          label: t.passwordLabel,
                          hint: t.passwordHint,
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: true,
                          isRtl: Directionality.of(context) == TextDirection.rtl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return t.passwordRequired;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl - 8,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: Text(
                          t.forgotPassword,
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: FilledButton(
                              onPressed: _isLoading ? null : _onLogin,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusMd,
                                  ),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      t.login,
                                      style: AppTypography.titleMedium.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              t.noAccount,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.go('/onboarding/signup'),
                              child: Text(
                                t.signUp,
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    if (_lastRateLimitHit != null) {
      final elapsed = DateTime.now().difference(_lastRateLimitHit!).inSeconds;
      if (elapsed < 120) {
        final remaining = 120 - elapsed;
        final t = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${t.errorRateLimit} ($remaining ${t.seconds(remaining)})'),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 4),
          ),
        );
        return;
      }
      _lastRateLimitHit = null;
    }

    setState(() => _isLoading = true);
    try {
      await sl<AuthRemoteDataSource>().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      await _syncPendingOnboardingData();
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().toLowerCase();
      if (msg.contains('429') || msg.contains('too many requests') ||
          msg.contains('over_request_rate_limit') || msg.contains('rate_limit')) {
        _lastRateLimitHit = DateTime.now();
      }
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_formatAuthError(e)),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Future<void> _syncPendingOnboardingData() async {
    try {
      final level = await sl<UserLocalDataSource>().getOnboardingLevel();
      final interests = await sl<UserLocalDataSource>()
          .getOnboardingInterests();
      if (level == null && (interests == null || interests.isEmpty)) return;
      final profile = <String, dynamic>{};
      if (level != null) profile['level'] = level;
      if (interests != null && interests.isNotEmpty) {
        profile['interests'] = interests;
      }
      await sl<AuthRemoteDataSource>().updateProfile(profile);
      await sl<UserLocalDataSource>().markOnboardingComplete();
      await sl<UserLocalDataSource>().clearOnboardingSelections();
    } catch (_) {}
  }

  String _formatAuthError(Object e) {
    final t = AppLocalizations.of(context);
    final msg = e.toString().toLowerCase();

    if (e is SocketException || e is TimeoutException || e is HandshakeException) {
      return t.errorNetwork;
    }

    if (msg.contains('429') || msg.contains('too many requests') ||
        msg.contains('over_request_rate_limit') || msg.contains('rate_limit')) {
      return t.errorRateLimit;
    }
    if (msg.contains('email not confirmed') ||
        msg.contains('email_not_confirmed')) {
      return t.errorEmailNotConfirmed;
    }
    if (msg.contains('invalid login') || msg.contains('invalid credentials')) {
      return t.errorInvalidCredentials;
    }
    return t.errorGeneric;
  }
}
