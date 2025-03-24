import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import screens when they are created
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/onboarding_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/details/screens/details_screen.dart';
import '../features/player/screens/player_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/profile/screens/profile_screen.dart';

// Router configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    // Splash and Auth routes
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // Main app routes
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final contentId = state.pathParameters['id']!;
        return DetailsScreen(contentId: contentId);
      },
    ),
    GoRoute(
      path: '/player/:id',
      builder: (context, state) {
        final contentId = state.pathParameters['id']!;
        final odyseeUrl = state.uri.queryParameters['url'] ?? '';
        return PlayerScreen(contentId: contentId, odyseeUrl: odyseeUrl);
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Route not found: ${state.uri.path}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  ),
); 