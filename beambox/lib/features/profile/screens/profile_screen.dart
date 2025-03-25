import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../config/theme.dart';
import '../../../services/firebase_auth_service.dart';
import '../../../widgets/glassmorphic_container.dart';
import '../../../widgets/custom_button.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final authService = ref.watch(firebaseAuthServiceProvider);
    
    // Mock user data
    final userData = {
      'name': 'Alex Johnson',
      'email': ref.watch(currentUserProvider)?.email ?? 'user@example.com',
      'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
      'plan': 'Premium',
      'joinedDate': 'January 2023',
      'watchlist': 7,
      'favoritesCount': 12,
      'watchHistory': 28,
    };

    final settingsOptions = [
      {
        'title': 'Account',
        'icon': Icons.person_outline,
        'items': [
          {'title': 'Edit Profile', 'icon': Icons.edit_outlined},
          {'title': 'Change Password', 'icon': Icons.lock_outline},
          {'title': 'Subscription Plan', 'icon': Icons.card_membership_outlined},
          {'title': 'Payment Methods', 'icon': Icons.credit_card_outlined},
        ],
      },
      {
        'title': 'Preferences',
        'icon': Icons.settings_outlined,
        'items': [
          {'title': 'Theme', 'icon': Icons.palette_outlined},
          {'title': 'Notifications', 'icon': Icons.notifications_outlined},
          {'title': 'Language', 'icon': Icons.language_outlined},
          {'title': 'Playback Settings', 'icon': Icons.play_circle_outline},
        ],
      },
      {
        'title': 'Privacy & Security',
        'icon': Icons.security_outlined,
        'items': [
          {'title': 'Privacy Settings', 'icon': Icons.privacy_tip_outlined},
          {'title': 'Data Usage', 'icon': Icons.data_usage_outlined},
          {'title': 'Download Quality', 'icon': Icons.high_quality_outlined},
        ],
      },
    ];
    
    // Logout function
    Future<void> handleLogout() async {
      try {
        isLoading.value = true;
        
        // Show a fancy logout animation
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Logging out...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        
        // Sign out from Firebase
        await authService.signOut();
        
        if (context.mounted) {
          // Dismiss the dialog
          Navigator.of(context).pop();
          
          // Navigate with hero animation to onboarding
          context.go('/onboarding');
        }
      } catch (e) {
        // Show error message
        if (context.mounted) {
          Navigator.of(context).pop(); // Dismiss dialog if open
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout failed: ${e.toString()}')),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: handleLogout,
            tooltip: 'Logout',
          ).animate().fade(duration: 500.ms).scale(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(userData),
              const SizedBox(height: 24),
              _buildProfileStats(userData),
              const SizedBox(height: 32),
              _buildSettingsSection(context, settingsOptions),
              const SizedBox(height: 24),
              _buildLogoutButton(handleLogout, isLoading.value),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> userData) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.surfaceColor,
            AppTheme.backgroundColor,
          ],
        ),
      ),
      child: Column(
        children: [
          // User avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: AppTheme.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: AppTheme.primaryShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0), // Border width
              child: ClipOval(
                child: Container(
                  color: AppTheme.surfaceColor,
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          )
              .animate()
              .fade(duration: 500.ms)
              .scale(begin: const Offset(0.8, 0.8)),
          
          const SizedBox(height: 16),
          
          // User name
          Text(
            userData['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
              .animate()
              .fade(delay: 200.ms, duration: 500.ms)
              .slideY(begin: 10, end: 0),
          
          const SizedBox(height: 4),
          
          // User email
          Text(
            userData['email'],
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          )
              .animate()
              .fade(delay: 300.ms, duration: 500.ms)
              .slideY(begin: 10, end: 0),
          
          const SizedBox(height: 12),
          
          // Subscription badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppTheme.primaryGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  userData['plan'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fade(delay: 400.ms, duration: 500.ms)
              .scale(begin: const Offset(0.8, 0.8)),
        ],
      ),
    );
  }

  Widget _buildProfileStats(Map<String, dynamic> userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Watchlist', userData['watchlist'].toString(), Icons.bookmark_border),
          _buildStatItem('Favorites', userData['favoritesCount'].toString(), Icons.favorite_border),
          _buildStatItem('History', userData['watchHistory'].toString(), Icons.history),
        ],
      ),
    )
        .animate()
        .fade(duration: 400.ms)
        .slideY(
          begin: 20,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildStatItem(String title, String count, IconData icon) {
    return GlassmorphicContainer(
      borderRadius: 16,
      blur: 10,
      opacity: 0.2,
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.textMuted.withOpacity(0.2),
          AppTheme.textMuted.withOpacity(0.2),
        ],
      ),
      backgroundGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.surfaceColor.withOpacity(0.3),
          AppTheme.surfaceColor.withOpacity(0.1),
        ],
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, List<Map<String, dynamic>> settingsOptions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Settings groups
          ...settingsOptions.map((group) => _buildSettingsGroup(context, group)).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, Map<String, dynamic> group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group heading
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 12),
            child: Row(
              children: [
                Icon(
                  group['icon'] as IconData,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  group['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Group items
          GlassmorphicContainer(
            borderRadius: 16,
            blur: 10,
            opacity: 0.2,
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.textMuted.withOpacity(0.2),
                AppTheme.textMuted.withOpacity(0.1),
              ],
            ),
            backgroundGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.surfaceColor.withOpacity(0.4),
                AppTheme.surfaceColor.withOpacity(0.2),
              ],
            ),
            child: Column(
              children: [
                ...(group['items'] as List<Map<String, dynamic>>)
                    .map((item) => _buildSettingsItem(context, item))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, Map<String, dynamic> item) {
    return ListTile(
      leading: Icon(
        item['icon'] as IconData,
        color: AppTheme.textSecondary,
        size: 20,
      ),
      title: Text(
        item['title'] as String,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppTheme.textMuted,
        size: 16,
      ),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(VoidCallback onLogout, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GlassmorphicContainer(
        borderRadius: 16,
        blur: 10,
        opacity: 0.1,
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
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
        child: CustomButton(
          text: 'Logout to Get Started Page',
          onPressed: onLogout,
          isLoading: isLoading,
          isPrimary: false,
          icon: Icons.logout,
          backgroundColor: Colors.transparent,
          textColor: AppTheme.primaryColor,
        ),
      ),
    ).animate()
      .fade(delay: 800.ms, duration: 400.ms)
      .slideY(begin: 20, end: 0, delay: 800.ms, duration: 400.ms, curve: Curves.easeOutQuint);
  }
} 