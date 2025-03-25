import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../config/theme.dart';
import '../../../services/firebase_auth_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/glassmorphic_container.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final isLogin = useState(true);
    final authService = ref.watch(firebaseAuthServiceProvider);
    
    // Form validation
    final formKey = useMemoized(() => GlobalKey<FormState>());
    
    // Error message
    final errorMessage = useState<String?>(null);
    
    // Authentication functions
    Future<void> _handleEmailAuth() async {
      if (formKey.currentState?.validate() ?? false) {
        try {
          isLoading.value = true;
          errorMessage.value = null;
          
          if (isLogin.value) {
            // Login
            await authService.signInWithEmailAndPassword(
              emailController.text.trim(), 
              passwordController.text.trim(),
            );
            if (context.mounted) {
              context.go('/home');
            }
          } else {
            // Sign up
            await authService.signUpWithEmailAndPassword(
              emailController.text.trim(), 
              passwordController.text.trim(),
            );
            if (context.mounted) {
              context.go('/home');
            }
          }
        } catch (e) {
          errorMessage.value = _getErrorMessage(e);
        } finally {
          isLoading.value = false;
        }
      }
    }
    
    Future<void> _handleGoogleSignIn() async {
      try {
        isLoading.value = true;
        errorMessage.value = null;
        
        final userCredential = await authService.signInWithGoogle();
        if (userCredential != null && context.mounted) {
          context.go('/home');
        }
      } catch (e) {
        errorMessage.value = _getErrorMessage(e);
      } finally {
        isLoading.value = false;
      }
    }
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppTheme.backgroundColor,
                  AppTheme.primaryColor.withOpacity(0.3),
                  AppTheme.accentColor.withOpacity(0.3),
                  AppTheme.backgroundColor,
                ],
              ),
            ),
          ),
          
          // Blurry circular shapes for decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          
          Positioned(
            bottom: -150,
            left: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.accentColor.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accentColor.withOpacity(0.3),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        
                        // Lottie Animation
                        Lottie.asset(
                          'assets/animations/login_lottie.json',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        
                        // App Title
                        Text(
                          'BeamBox',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: AppTheme.primaryGradient,
                              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                            letterSpacing: 2,
                            shadows: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fade(duration: 800.ms)
                            .slideY(begin: 10, end: 0, duration: 800.ms, curve: Curves.easeOutQuint),
                        
                        const SizedBox(height: 8),
                        
                        // Tagline
                        Text(
                          'Stream Beyond Boundaries',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        )
                            .animate()
                            .fade(delay: 200.ms, duration: 800.ms)
                            .slideY(delay: 200.ms, begin: 10, end: 0, duration: 800.ms, curve: Curves.easeOutQuint),
                        
                        const SizedBox(height: 40),
                        
                        // Login/Signup Form
                        GlassmorphicContainer(
                          borderRadius: 20,
                          blur: 20,
                          opacity: 0.2,
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
                              AppTheme.primaryColor.withOpacity(0.1),
                              AppTheme.surfaceColor.withOpacity(0.2),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                // Title
                                Text(
                                  isLogin.value ? 'Welcome Back' : 'Create Account',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                
                                const SizedBox(height: 24),
                                
                                // Email field
                                CustomTextField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  prefixIcon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Password field
                                CustomTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (!isLogin.value && value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                
                                const SizedBox(height: 8),
                                
                                // Forgot password
                                if (isLogin.value)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // TODO: Implement forgot password
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                
                                // Error message
                                if (errorMessage.value != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      errorMessage.value!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                      .animate()
                                      .fade()
                                      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
                                
                                const SizedBox(height: 24),
                                
                                // Login/Sign Up button
                                CustomButton(
                                  onPressed: _handleEmailAuth,
                                  isLoading: isLoading.value,
                                  text: isLogin.value ? 'Login' : 'Sign Up',
                                  gradient: LinearGradient(
                                    colors: AppTheme.primaryGradient,
                                  ),
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: AppTheme.textMuted,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Text(
                                        'OR',
                                        style: TextStyle(
                                          color: AppTheme.textMuted,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: AppTheme.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Google sign in button
                                CustomButton(
                                  onPressed: _handleGoogleSignIn,
                                  isLoading: false,
                                  text: 'Continue with Google',
                                  icon: Icons.g_mobiledata,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black87,
                                ),
                              ],
                            ),
                          ),
                        )
                            .animate()
                            .fade(delay: 400.ms, duration: 800.ms)
                            .scale(
                              delay: 400.ms,
                              duration: 800.ms,
                              begin: const Offset(0.9, 0.9),
                              end: const Offset(1, 1),
                              curve: Curves.easeOutQuint,
                            ),
                        
                        const Spacer(),
                        
                        // Toggle between login and sign up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLogin.value
                                  ? 'Don\'t have an account?'
                                  : 'Already have an account?',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                isLogin.value = !isLogin.value;
                                errorMessage.value = null;
                              },
                              child: Text(
                                isLogin.value ? 'Sign Up' : 'Login',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        )
                            .animate()
                            .fade(delay: 600.ms, duration: 800.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getErrorMessage(dynamic error) {
    if (error is Exception) {
      final message = error.toString();
      
      if (message.contains('user-not-found')) {
        return 'No user found with this email';
      } else if (message.contains('wrong-password')) {
        return 'Incorrect password';
      } else if (message.contains('email-already-in-use')) {
        return 'This email is already registered';
      } else if (message.contains('weak-password')) {
        return 'Password is too weak';
      } else if (message.contains('invalid-email')) {
        return 'Invalid email format';
      } else if (message.contains('network-request-failed')) {
        return 'Network error. Please check your connection';
      }
    }
    
    return 'An error occurred. Please try again later';
  }
} 