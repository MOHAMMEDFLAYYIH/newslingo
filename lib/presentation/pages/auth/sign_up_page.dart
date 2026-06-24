import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/local/user_local_datasource.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/presentation/widgets/app_text_field.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (!_emailSent)
                    ..._buildFormFields()
                  else
                    ..._buildSuccessState(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    final t = AppLocalizations.of(context);
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.signUpTitle, style: AppTypography.displayMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.signUpSubtitle,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.xl4),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          children: [
            AppTextField(
              controller: _nameController,
              label: t.getNameLabel,
              hint: t.getNameHint,
              prefixIcon: Icons.person_outline_rounded,
              isRtl: Directionality.of(context) == TextDirection.rtl,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return t.getNameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _emailController,
              label: t.emailLabel,
              hint: t.emailHint,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              isRtl: Directionality.of(context) == TextDirection.rtl,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return t.emailRequired;
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return t.emailInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _passwordController,
              label: t.passwordLabel,
              hint: t.passwordMin,
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: true,
              isRtl: Directionality.of(context) == TextDirection.rtl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.passwordRequired;
                }
                if (value.length < 6) {
                  return t.passwordLengthError;
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _confirmPasswordController,
              label: t.confirmPasswordLabel,
              hint: t.confirmPasswordHint,
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: true,
              isRtl: Directionality.of(context) == TextDirection.rtl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return t.confirmPasswordRequired;
                }
                if (value != _passwordController.text) {
                  return t.passwordsMismatch;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.xxl),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Row(
          children: [
            SizedBox(
              height: 22,
              width: 22,
              child: Checkbox(
                value: _agreedToTerms,
                onChanged: (value) {
                  setState(() => _agreedToTerms = value ?? false);
                },
                activeColor: AppColors.primary,
                checkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                ),
                side: BorderSide(
                  color: _agreedToTerms ? AppColors.primary : AppColors.outline,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                t.agreeTerms,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.xxl),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  boxShadow: _agreedToTerms && !_isLoading
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : null,
                ),
                child: FilledButton(
                  onPressed: (_agreedToTerms && !_isLoading) ? _onSignUp : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: _agreedToTerms
                        ? AppColors.primary
                        : AppColors.outline.withValues(alpha: 0.5),
                    disabledBackgroundColor: AppColors.outline.withValues(
                      alpha: 0.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
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
                          t.createAccount,
                          style: AppTypography.titleMedium.copyWith(
                            color: _agreedToTerms
                                ? Colors.white
                                : AppColors.textTertiary,
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
                  t.haveAccount,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    t.login,
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
      const SizedBox(height: AppSpacing.xl4),
    ];
  }

  List<Widget> _buildSuccessState() {
    final t = AppLocalizations.of(context);
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.accountCreated, style: AppTypography.displayMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.checkEmail,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.xl5),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('📧', style: TextStyle(fontSize: 56)),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              t.verificationSent,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              t.verificationDetail,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl4),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () => context.go('/login'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Text(
                  t.login,
                  style: AppTypography.titleMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Future<void> _onSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final result = await sl<AuthRemoteDataSource>().signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
      );

      if (!mounted) return;

      await _saveOnboardingData();
      if (!mounted) return;

      final session = result['session'];
      if (session != null) {
        await sl<UserLocalDataSource>().markOnboardingComplete();
        if (!mounted) return;
        await sl<UserLocalDataSource>().clearOnboardingSelections();
        if (!mounted) return;
        if (mounted) context.go('/home');
      } else {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      final message = _formatAuthError(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Future<void> _saveOnboardingData() async {
    try {
      final level = await sl<UserLocalDataSource>().getOnboardingLevel();
      final interests = await sl<UserLocalDataSource>()
          .getOnboardingInterests();
      final profile = <String, dynamic>{};
      if (level != null) { profile['language_level'] = level; }
      if (interests != null && interests.isNotEmpty) {
        profile['interests'] = interests;
      }
      if (profile.isNotEmpty) {
        await sl<AuthRemoteDataSource>().updateProfile(profile);
      }
    } catch (_) {}
  }

  String _formatAuthError(Object e) {
    final t = AppLocalizations.of(context);
    final msg = e.toString().toLowerCase();
    if (msg.contains('429') || msg.contains('too many requests')) {
      return t.errorRateLimit;
    }
    if (msg.contains('email not confirmed') ||
        msg.contains('email_not_confirmed')) {
      return t.errorEmailNotConfirmed;
    }
    if (msg.contains('already registered') ||
        msg.contains('user already exists')) {
      return t.errorAlreadyRegistered;
    }
    if (msg.contains('invalid email')) {
      return t.emailInvalid;
    }
    if (msg.contains('weak password')) {
      return t.errorWeakPassword;
    }
    return t.errorGeneric;
  }
}
