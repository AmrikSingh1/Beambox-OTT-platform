import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';

import '../../../config/theme.dart';
import 'onboarding_screen.dart'; // We'll create this next

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation
            _buildLogo()
                .animate()
                .fade(duration: 600.ms)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                ),
                
            const SizedBox(height: 40),
            
            // Tagline animation
            Text(
              'Future of Entertainment',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            )
                .animate(delay: 400.ms)
                .fade(duration: 500.ms)
                .slideY(
                  begin: 20,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                ),
                
            const SizedBox(height: 80),
            
            // Loading indicator
            _buildLoadingIndicator()
                .animate(delay: 800.ms)
                .fade(duration: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: AppTheme.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: AppTheme.primaryShadow,
          ),
          child: Center(
            child: Text(
              'B',
              style: TextStyle(
                color: Colors.white,
                fontSize: 72,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: AppTheme.primaryColor.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'BeamBox',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: AppTheme.primaryColor.withOpacity(0.5),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 160,
      child: LinearProgressIndicator(
        backgroundColor: AppTheme.surfaceColor,
        color: AppTheme.secondaryColor,
        minHeight: 6,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
} 