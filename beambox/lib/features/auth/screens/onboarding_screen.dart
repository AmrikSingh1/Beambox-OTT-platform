import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../config/theme.dart';
import '../../../services/firebase_auth_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/glassmorphic_container.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final authService = ref.watch(firebaseAuthServiceProvider);
    
    // Animation controller for coordinated animations
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );
    
    // Start the animation when the screen loads
    useEffect(() {
      animationController.forward();
      return null;
    }, const []);
    
    // Function to handle Google sign in
    Future<void> handleGoogleSignIn() async {
      try {
        final userCredential = await authService.signInWithGoogle();
        if (userCredential != null && context.mounted) {
          // Animate out before navigation
          await animationController.reverse();
          if (context.mounted) {
            context.go('/home');
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign in failed: ${e.toString()}')),
          );
        }
      }
    }
    
    // Function to navigate to login page
    Future<void> navigateToLogin() async {
      // Animate out before navigation
      await animationController.reverse();
      if (context.mounted) {
        context.go('/login');
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Background gradient and design elements with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppTheme.backgroundColor,
                      AppTheme.primaryColor.withOpacity(0.2 * animationController.value),
                      AppTheme.accentColor.withOpacity(0.2 * animationController.value),
                      AppTheme.backgroundColor,
                    ],
                  ),
                ),
              ),
              
              // Animated blurry circular elements
              Positioned(
                top: -size.height * 0.15,
                right: -size.width * 0.2 + (20 * animationController.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  width: size.width * 0.7,
                  height: size.width * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.2 * animationController.value),
                        AppTheme.primaryColor.withOpacity(0.05 * animationController.value),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.2 * animationController.value),
                        blurRadius: 60 * animationController.value,
                        spreadRadius: 10 * animationController.value,
                      ),
                    ],
                  ),
                ),
              ),
              
              Positioned(
                bottom: -size.height * 0.2,
                left: -size.width * 0.2 + (20 * animationController.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  width: size.width * 0.7,
                  height: size.width * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.accentColor.withOpacity(0.2 * animationController.value),
                        AppTheme.accentColor.withOpacity(0.05 * animationController.value),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentColor.withOpacity(0.2 * animationController.value),
                        blurRadius: 60 * animationController.value,
                        spreadRadius: 10 * animationController.value,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Main Content with animations
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      
                      // Lottie Animation with staggered animation
                      Opacity(
                        opacity: animationController.value,
                        child: Transform.scale(
                          scale: 0.8 + (0.2 * animationController.value),
                          child: Hero(
                            tag: 'lottie_animation',
                            child: Lottie.asset(
                              'assets/animations/login_lottie.json',
                              width: size.width * 0.8,
                              height: size.width * 0.8,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ).animate().custom(
                        delay: 300.ms,
                        duration: 800.ms,
                        builder: (context, value, child) => Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // App Title with Animated Gradient
                      Opacity(
                        opacity: animationController.value,
                        child: Transform.scale(
                          scale: 0.9 + (0.1 * animationController.value),
                          child: Hero(
                            tag: 'app_title',
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: AppTheme.primaryGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                'BeamBox',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animate().custom(
                        delay: 500.ms,
                        duration: 800.ms,
                        builder: (context, value, child) => Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Tagline with animation
                      Opacity(
                        opacity: animationController.value,
                        child: Text(
                          'Stream Beyond Boundaries',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ).animate().custom(
                        delay: 700.ms,
                        duration: 800.ms,
                        builder: (context, value, child) => Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      ),
                      
                      const Spacer(flex: 1),
                      
                      // Get Started Button with card
                      Opacity(
                        opacity: animationController.value,
                        child: Transform.scale(
                          scale: 0.95 + (0.05 * animationController.value),
                          child: GlassmorphicContainer(
                            borderRadius: 20,
                            blur: 10,
                            opacity: 0.1,
                            borderGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.5),
                                Colors.white.withOpacity(0.2),
                              ],
                            ),
                            backgroundGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppTheme.primaryColor.withOpacity(0.2),
                                AppTheme.surfaceColor.withOpacity(0.2),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Start Streaming',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 12),
                                  
                                  const Text(
                                    'Experience seamless streaming with unlimited content. Sign in to continue.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 24),
                                  
                                  // Get Started Button
                                  CustomButton(
                                    text: 'Get Started',
                                    onPressed: navigateToLogin,
                                    gradient: LinearGradient(
                                      colors: AppTheme.primaryGradient,
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // Sign in with Google
                                  CustomButton(
                                    text: 'Continue with Google',
                                    onPressed: handleGoogleSignIn,
                                    icon: Icons.g_mobiledata,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black87,
                                    isPrimary: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).animate().custom(
                        delay: 900.ms,
                        duration: 800.ms,
                        builder: (context, value, child) => Transform.translate(
                          offset: Offset(0, 40 * (1 - value)),
                          child: child,
                        ),
                      ),
                      
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 