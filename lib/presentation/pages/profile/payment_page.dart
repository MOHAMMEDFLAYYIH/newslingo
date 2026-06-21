import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic>? plan;

  const PaymentPage({super.key, this.plan});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardholderController = TextEditingController();
  final _promoController = TextEditingController();

  String _selectedMethod = 'card';
  bool _isPromoApplied = false;

  String _planTitle = '';
  double _planPrice = 79.99;

  @override
  void initState() {
    super.initState();
    if (widget.plan != null) {
      _planPrice = (widget.plan!['price'] as num?)?.toDouble() ?? 79.99;
      _planTitle = widget.plan!['title'] as String? ?? 'Annual Plan';
    }
  }

  double get _discount => _isPromoApplied ? 16.0 : 0.0;
  double get _total => _planPrice - _discount;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardholderController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  void _applyPromo() {
    if (_promoController.text.trim().isNotEmpty) {
      setState(() => _isPromoApplied = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  child: Row(
                    children: [
                      AppBackButton(),
                      const Spacer(),
                      Text(
                        t.paymentTitle,
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
                _CardPreview(
                  planTitle: _planTitle,
                  planPrice: _planPrice,
                  cardholderName: _cardholderController.text.isEmpty
                      ? t.paymentCardHolder
                      : _cardholderController.text,
                  cardNumber: _cardNumberController.text.isEmpty
                      ? '•••• •••• •••• ••••'
                      : _formatCardNumber(_cardNumberController.text),
                  expiry: _expiryController.text.isEmpty ? 'MM/YY' : _expiryController.text,
                ),
                const SizedBox(height: AppSpacing.xl),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.paymentMethod,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _PaymentMethodOption(
                        emoji: '💳',
                        label: t.paymentCreditCard,
                        isSelected: _selectedMethod == 'card',
                        onTap: () => setState(() => _selectedMethod = 'card'),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _PaymentMethodOption(
                        emoji: '🍎',
                        label: 'Apple Pay',
                        isSelected: _selectedMethod == 'apple',
                        onTap: () => setState(() => _selectedMethod = 'apple'),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _PaymentMethodOption(
                        emoji: '🅿️',
                        label: 'PayPal',
                        isSelected: _selectedMethod == 'paypal',
                        onTap: () => setState(() => _selectedMethod = 'paypal'),
                      ),
                      if (_selectedMethod == 'card') ...[
                        const SizedBox(height: AppSpacing.xxl),
                        Text(
                          t.paymentCardInfo,
                          style: AppTypography.titleSmall.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _CardField(
                          controller: _cardholderController,
                          label: t.paymentCardHolder,
                          hint: t.paymentCardHolderHint,
                          prefix: '👤',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _CardField(
                          controller: _cardNumberController,
                          label: t.paymentCardNumber,
                          hint: '0000 0000 0000 0000',
                          prefix: '🔢',
                          keyboardType: TextInputType.number,
                          maxLength: 19,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            Expanded(
                              child: _CardField(
                                controller: _expiryController,
                                label: t.paymentExpiry,
                                hint: 'MM/YY',
                                prefix: '📅',
                                keyboardType: TextInputType.datetime,
                                maxLength: 5,
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: _CardField(
                                controller: _cvvController,
                                label: 'CVV',
                                hint: '•••',
                                prefix: '🔒',
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        t.paymentDiscount,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: _CardField(
                              controller: _promoController,
                              label: t.paymentDiscountHint,
                              hint: 'NEWSLINGO20',
                              prefix: '🏷️',
                              enabled: !_isPromoApplied,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          SizedBox(
                            height: 52,
                            child: FilledButton(
                              onPressed: _isPromoApplied ? null : _applyPromo,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusMd,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xl,
                                ),
                              ),
                              child: Text(
                                _isPromoApplied ? '✓' : t.paymentApply,
                                style: AppTypography.labelLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_isPromoApplied)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                size: 16,
                                color: AppColors.success,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                t.paymentApplied,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: AppSpacing.xxl),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                            color: AppColors.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Column(
                          children: [
                            _PriceRow(
                              label: t.paymentSubtotal,
                              amount: '\$${_planPrice.toStringAsFixed(2)}',
                            ),
                            if (_isPromoApplied) ...[
                              const SizedBox(height: AppSpacing.sm),
                              _PriceRow(
                                label: t.paymentDiscountLabel,
                                amount: '-\$${_discount.toStringAsFixed(2)}',
                                color: AppColors.success,
                              ),
                            ],
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                              child: Divider(height: 1),
                            ),
                            _PriceRow(
                              label: t.paymentTotal,
                              amount: '\$${_total.toStringAsFixed(2)}',
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        t.subscriptionAutoRenew,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.paymentSuccess)),
                            );
                            Future.delayed(const Duration(seconds: 1), () {
                              if (context.mounted) context.pop();
                            });
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.lg,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            t.paymentPay(_total),
                            style: AppTypography.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.xl5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  String _formatCardNumber(String number) {
    final cleaned = number.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }
}

class _CardPreview extends StatelessWidget {
  final String planTitle;
  final double planPrice;
  final String cardholderName;
  final String cardNumber;
  final String expiry;

  const _CardPreview({
    required this.planTitle,
    required this.planPrice,
    required this.cardholderName,
    required this.cardNumber,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A1A2E).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('💳', style: TextStyle(fontSize: 24)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(
                      planTitle,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                cardNumber,
                style: const TextStyle(
                  fontFamily: '.SF Pro Display',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.paymentCardHolderShort,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white.withValues(alpha: 0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          cardholderName,
                          style: const TextStyle(
                            fontFamily: '.SF Pro Display',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        t.paymentExpiry,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        expiry,
                        style: const TextStyle(
                          fontFamily: '.SF Pro Display',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodOption({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.outline.withValues(alpha: 0.3),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: AppSpacing.md),
            Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CardField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String prefix;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;
  final bool enabled;
  final void Function(String)? onChanged;

  const _CardField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefix,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: AppColors.outline.withValues(alpha: 0.3),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: obscureText,
        enabled: enabled,
        onChanged: onChanged,
        style: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.textTertiary,
            fontSize: 14,
          ),
          labelStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.primary,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.md, end: AppSpacing.sm),
            child: Text(prefix, style: const TextStyle(fontSize: 18)),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
        ),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;
  final Color? color;

  const _PriceRow({
    required this.label,
    required this.amount,
    this.isTotal = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: (isTotal ? AppTypography.titleSmall : AppTypography.bodyMedium).copyWith(
            color: color ?? AppColors.textSecondary,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          amount,
          style: (isTotal ? AppTypography.titleMedium : AppTypography.bodyLarge).copyWith(
            color: color ?? AppColors.textPrimary,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
