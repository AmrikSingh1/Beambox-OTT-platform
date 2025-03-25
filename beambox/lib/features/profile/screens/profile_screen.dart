import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../config/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Alex Johnson',
    'email': 'alex.johnson@example.com',
    'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
    'plan': 'Premium',
    'joinedDate': 'January 2023',
    'watchlist': 7,
    'favoritesCount': 12,
    'watchHistory': 28,
  };

  final List<Map<String, dynamic>> _settingsOptions = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildProfileStats(),
              const SizedBox(height: 32),
              _buildSettingsSection(),
              const SizedBox(height: 24),
              _buildLogoutButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
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
                child: CachedNetworkImage(
                  imageUrl: _userData['avatar'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppTheme.cardColor,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppTheme.cardColor,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white54,
                    ),
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
            _userData['name'],
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
            _userData['email'],
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
                  _userData['plan'],
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

  Widget _buildProfileStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Watchlist', _userData['watchlist'].toString(), Icons.bookmark_border),
          _buildStatItem('Favorites', _userData['favoritesCount'].toString(), Icons.favorite_border),
          _buildStatItem('History', _userData['watchHistory'].toString(), Icons.history),
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
      width: 100,
      height: 100,
      borderRadius: 16,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.surfaceColor.withOpacity(0.3),
          AppTheme.surfaceColor.withOpacity(0.1),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.textMuted.withOpacity(0.2),
          AppTheme.textMuted.withOpacity(0.2),
        ],
      ),
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
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
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
          ..._settingsOptions.map((group) => _buildSettingsGroup(group)).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(Map<String, dynamic> group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(
                  group['icon'],
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  group['title'],
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
          ...(group['items'] as List<Map<String, dynamic>>).map(
            (item) => ListTile(
              leading: Icon(
                item['icon'],
                color: AppTheme.textSecondary,
                size: 20,
              ),
              title: Text(
                item['title'],
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.surfaceColor,
          foregroundColor: AppTheme.textSecondary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 18),
            SizedBox(width: 8),
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 