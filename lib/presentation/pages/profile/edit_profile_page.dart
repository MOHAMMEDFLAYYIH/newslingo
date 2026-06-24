import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/remote/auth_remote_datasource.dart';
import 'package:newslingo/presentation/widgets/app_text_field.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

final List<({String code, String Function(AppLocalizations) label})>
    _levelOptions = [
  (code: 'A1', label: (t) => t.editProfileLevelA1),
  (code: 'A2', label: (t) => t.editProfileLevelA2),
  (code: 'B1', label: (t) => t.editProfileLevelB1),
  (code: 'B2', label: (t) => t.editProfileLevelB2),
  (code: 'C1', label: (t) => t.editProfileLevelC1),
  (code: 'C2', label: (t) => t.editProfileLevelC2),
];

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  String _selectedLevel = '';
  final Set<String> _selectedInterests = <String>{};
  bool _isLoading = true;
  bool _hasLoadError = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await sl<AuthRemoteDataSource>().getProfile();
      if (!mounted) return;
      if (profile != null) {
        _nameController.text = profile['name'] as String? ?? '';
        _emailController.text = profile['email'] as String? ?? '';
        _bioController.text = profile['bio'] as String? ?? '';
        _selectedLevel = _normalizeLevel(profile['level'] as String? ?? '');
        if (profile['interests'] != null) {
          final interests = profile['interests'] as List<dynamic>;
          _selectedInterests.addAll(interests.cast<String>());
        }
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _hasLoadError = true);
    }
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  String _normalizeLevel(String level) {
    if (level.contains(' - ')) {
      final code = level.split(' - ').first.trim();
      if (_levelOptions.any((o) => o.code == code)) return code;
    }
    if (_levelOptions.any((o) => o.code == level)) return level;
    return '';
  }

  List<String> _buildInterests(AppLocalizations t) => [
    t.editProfileInterestNews,
    t.editProfileInterestTech,
    t.editProfileInterestSports,
    t.editProfileInterestScience,
    t.editProfileInterestBusiness,
    t.editProfileInterestEntertainment,
    t.editProfileInterestHealth,
    t.editProfileInterestWorld,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
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
    if (_hasLoadError) {
      return Scaffold(
        appBar: AppBar(title: Text(t.editProfileTitle)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('😕', style: TextStyle(fontSize: 64)),
              const SizedBox(height: AppSpacing.lg),
              Text(t.errorGeneric),
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _hasLoadError = false;
                  });
                  _loadProfile();
                },
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: Text(t.homeRetry),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    child: Row(
                      children: [
                        AppBackButton(),
                        const Spacer(),
                        Text(
                          t.editProfileTitle,
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _AvatarSection(),
                  const SizedBox(height: AppSpacing.xxl),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: _nameController,
                          label: t.getNameLabel,
                          hint: t.getNameHint,
                          prefixIcon: Icons.person_outline_rounded,
                          isRtl:
                              Directionality.of(context) == TextDirection.rtl,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child:                     _LevelDropdown(
                      value: _selectedLevel,
                      onChanged: (v) => setState(() => _selectedLevel = v!),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.editProfileBio,
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMd,
                            ),
                          ),
                          child: TextFormField(
                            controller: _bioController,
                            textDirection: Directionality.of(context),
                            maxLines: 4,
                            maxLength: 200,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: t.editProfileBioHint,
                              hintTextDirection: Directionality.of(context),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(
                                AppSpacing.lg,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                    ),
                    child: _InterestsSection(
                      interests: _buildInterests(t),
                      selected: _selectedInterests,
                      onToggle: (interest) {
                        setState(() {
                          if (_selectedInterests.contains(interest)) {
                            _selectedInterests.remove(interest);
                          } else {
                            _selectedInterests.add(interest);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl4),
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
                              onPressed: _onSave,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusMd,
                                  ),
                                ),
                              ),
                              child: Text(
                                t.editProfileSave,
                                style: AppTypography.titleMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: TextButton(
                            onPressed: () => context.pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textTertiary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd,
                                ),
                              ),
                            ),
                            child: Text(
                              t.editProfileCancel,
                              style: AppTypography.titleSmall.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;
    final t = AppLocalizations.of(context);
    try {
      await sl<AuthRemoteDataSource>().updateProfile({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'level': _selectedLevel,
        'bio': _bioController.text.trim(),
        'interests': _selectedInterests.toList(),
      });
      if (!mounted) return;
      context.pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${t.editProfileSaveError} $e')));
    }
  }
}

class _AvatarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Center(
                child: Text('🦉', style: TextStyle(fontSize: 52)),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -4,
              child:               GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image picker coming soon')),
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LevelDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const _LevelDropdown({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.editProfileLevel,
          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: DropdownButtonFormField<String>(
            key: ValueKey(value),
            initialValue: value.isEmpty ? null : value,
            items: _levelOptions.map((opt) {
              return DropdownMenuItem<String>(
                value: opt.code,
                child: Text(opt.label(t)),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textPrimary,
            ),
            icon: const Icon(
              Icons.expand_more_rounded,
              color: AppColors.textSecondary,
            ),
            dropdownColor: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ],
    );
  }
}

class _InterestsSection extends StatelessWidget {
  final List<String> interests;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _InterestsSection({
    required this.interests,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.editProfileInterests,
          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: interests.map((interest) {
            final isSelected = selected.contains(interest);
            return GestureDetector(
              onTap: () => onToggle(interest),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryContainer
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : Colors.transparent,
                  ),
                ),
                child: Text(
                  interest,
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
