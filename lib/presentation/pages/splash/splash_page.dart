import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:newslingo/core/localization/app_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _bounce;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _scale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _bounce = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.7, curve: Curves.bounceOut),
      ),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    Future.delayed(const Duration(milliseconds: 2600), _checkSession);
  }

  Future<void> _checkSession() async {
    if (!mounted) return;
    try {
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
          context.go('/home');
          return;
        }
      }
    } catch (_) {
      try {
        await Supabase.instance.client.auth.signOut();
      } catch (_) {}
    }
    if (!mounted) return;
    context.go('/onboarding');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF58CC02), Color(0xFF46A302), Color(0xFF3A8A02)],
          ),
        ),
        child: Stack(
          children: [
            ...List.generate(6, (i) => _buildFloatingCircle(i)),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _scale,
                    builder: (context, _) {
                      return Transform.scale(
                        scale: _scale.value,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: CustomPaint(painter: _BookPainter()),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  AnimatedBuilder(
                    animation: _fade,
                    builder: (context, _) {
                      return Opacity(
                        opacity: _fade.value,
                        child: Column(
                          children: [
                            Text(
                              t.splashTitle,
                              style: AppTypography.displayLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusFull,
                                ),
                              ),
                              child: Text(
                                t.splashSubtitle,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl5),
                  AnimatedBuilder(
                    animation: _bounce,
                    builder: (context, _) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - _bounce.value)),
                        child: Opacity(
                          opacity: _bounce.value,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCircle(int index) {
    final random = Random(index * 7);
    final size = 20.0 + random.nextDouble() * 60;
    final left = random.nextDouble() * 0.8 + 0.1;
    final top = random.nextDouble() * 0.8 + 0.1;
    final delay = index * 0.3;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final progress = (_controller.value - delay).clamp(0.0, 1.0);
        final opacity = (progress * 0.15).clamp(0.0, 0.15);
        return Positioned(
          left: MediaQuery.of(context).size.width * left - size / 2,
          top: MediaQuery.of(context).size.height * top - size / 2,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.primary;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.2,
          size.height * 0.2,
          size.width * 0.65,
          size.height * 0.6,
        ),
        const Radius.circular(6),
      ),
      paint..color = AppColors.primary,
    );

    final pagePaint = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.26,
          size.height * 0.26,
          size.width * 0.55,
          size.height * 0.48,
        ),
        const Radius.circular(3),
      ),
      pagePaint,
    );

    final linePaint = Paint()
      ..color = AppColors.outline.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (var i = 0; i < 4; i++) {
      final y = size.height * (0.34 + i * 0.08);
      canvas.drawLine(
        Offset(size.width * 0.3, y),
        Offset(size.width * 0.72, y),
        linePaint,
      );
    }

    final dotPaint = Paint()
      ..color = AppColors.accentYellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.7), 4, dotPaint);

    final dotPaint2 = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.68, size.height * 0.7),
      4,
      dotPaint2,
    );

    final spinePaint = Paint()
      ..color = AppColors.primaryDark
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.17,
          size.height * 0.22,
          size.width * 0.05,
          size.height * 0.56,
        ),
        const Radius.circular(2),
      ),
      spinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
