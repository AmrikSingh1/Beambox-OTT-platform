import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

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
    {
      'title': 'Support',
      'icon': Icons.help_outline,
      'items': [
        {'title': 'Help Center', 'icon': Icons.help_outline},
        {'title': 'Contact Us', 'icon': Icons.mail_outline},
        {'title': 'Report a Problem', 'icon': Icons.bug_report_outlined},
        {'title': 'About', 'icon': Icons.info_outline},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildProfileStats(),
              const SizedBox(height: 32),
              _buildSettingsSections(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Avatar
          GlassmorphicContainer(
            width: 90,
            height: 90,
            borderRadius: 45,
            blur: 10,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withOpacity(0.2),
                AppTheme.secondaryColor.withOpacity(0.2),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withOpacity(0.4),
                AppTheme.secondaryColor.withOpacity(0.4),
              ],
            ),
            child: Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(_userData['avatar']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          
          // Name and plan info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userData['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userData['email'],
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppTheme.primaryGradient,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_userData['plan']} Plan',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Edit button
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
          ),
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

  Widget _buildSettingsSections() {
    return Column(
      children: _settingsOptions.map((section) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Row(
                children: [
                  Icon(
                    section['icon'] as IconData,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    section['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: (section['items'] as List<Map<String, dynamic>>).map((item) {
                return _buildSettingsItem(
                  title: item['title'] as String,
                  icon: item['icon'] as IconData,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.textMuted,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.surfaceColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          Icons.logout,
          color: AppTheme.accentColor,
        ),
        label: Text(
          'Logout',
          style: TextStyle(
            color: AppTheme.accentColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
} 