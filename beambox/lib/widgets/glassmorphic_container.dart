import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Gradient borderGradient;
  final Gradient backgroundGradient;

  const GlassmorphicContainer({
    Key? key,
    required this.child,
    required this.borderRadius,
    required this.blur,
    required this.opacity,
    required this.borderGradient,
    required this.backgroundGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: borderGradient,
      ),
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius - 1),
          gradient: backgroundGradient,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius - 2),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius - 2),
                color: Colors.white.withOpacity(opacity),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
} 