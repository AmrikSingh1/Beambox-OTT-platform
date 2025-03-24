import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../config/theme.dart';
import 'login_screen.dart'; // Will create next

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to BeamBox',
      description: 'Experience the future of entertainment with our cutting-edge streaming platform',
      imagePath: 'assets/images/onboarding1.png', // Will add these images later
      color: AppTheme.primaryColor,
    ),
    OnboardingPage(
      title: 'Futuristic Experience',
      description: 'Enjoy stunning visuals and smooth animations in a beautiful interface',
      imagePath: 'assets/images/onboarding2.png',
      color: AppTheme.secondaryColor,
    ),
    OnboardingPage(
      title: 'Rich Content Library',
      description: 'Access a vast collection of movies, shows, and unique content',
      imagePath: 'assets/images/onboarding3.png',
      color: AppTheme.accentColor,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Skip button
            Positioned(
              top: 20,
              right: 20,
              child: TextButton(
                onPressed: _navigateToLogin,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            
            // Main content
            Column(
              children: [
                // Page view
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildPage(_pages[index], index);
                    },
                  ),
                ),
                
                // Page indicator and next button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page indicator
                      Row(
                        children: List.generate(
                          _pages.length,
                          (index) => _buildPageIndicator(index == _currentPage),
                        ),
                      ),
                      
                      // Next button
                      _buildNextButton(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, int index) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image placeholder - we'll add real images later
          Container(
            width: 280,
            height: 280,
            margin: const EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(
                _getIconForIndex(index),
                size: 100,
                color: page.color,
              ),
            ),
          )
              .animate()
              .fade(duration: 500.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 600.ms,
                curve: Curves.easeOutCubic,
              ),
              
          // Title
          Text(
            page.title,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          )
              .animate()
              .fade(delay: 200.ms, duration: 500.ms)
              .slideY(
                begin: 20,
                end: 0,
                delay: 200.ms,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),
              
          const SizedBox(height: 24),
          
          // Description
          Text(
            page.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fade(delay: 400.ms, duration: 500.ms)
              .slideY(
                begin: 20,
                end: 0,
                delay: 400.ms,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              ),
        ],
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.movie_outlined;
      case 1:
        return Icons.auto_awesome;
      case 2:
        return Icons.video_library_outlined;
      default:
        return Icons.play_circle_outline;
    }
  }

  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : AppTheme.textMuted,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: _onNextPage,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(60, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        _currentPage < _pages.length - 1 ? Icons.arrow_forward : Icons.check,
        size: 28,
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
  });
} 