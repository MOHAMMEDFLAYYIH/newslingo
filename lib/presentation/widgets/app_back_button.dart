import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  final double iconSize;
  final VoidCallback? onPressed;

  const AppBackButton({super.key, this.iconSize = 24, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return IconButton(
      icon: Icon(
        isRtl ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_rounded,
        size: iconSize,
      ),
      onPressed: onPressed ?? () => context.pop(),
    );
  }
}
