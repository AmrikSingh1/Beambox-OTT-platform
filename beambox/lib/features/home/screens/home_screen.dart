import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../config/theme.dart';
import '../widgets/category_selector.dart'; // Will create later
import '../widgets/featured_content.dart'; // Will create later
import '../widgets/content_row.dart'; // Will create later
import '../../details/screens/details_screen.dart'; // Will create later
import '../../search/screens/search_screen.dart'; // Will create later
import '../../profile/screens/profile_screen.dart'; // Will create later

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<String> _categories = ['All', 'Movies', 'Series', 'Shows', 'Documentaries'];
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      extendBody: true,
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBody() {
    // Show different screens based on selected bottom nav item
    if (_currentIndex == 1) {
      return const Center(child: Text('Coming Soon'));
    } else if (_currentIndex == 2) {
      return const SearchScreen();
    } else if (_currentIndex == 3) {
      return const ProfileScreen();
    }

    // Home screen content
    return Stack(
      children: [
        // Main scrollable content
        CustomScrollView(
          slivers: [
            // App bar with logo and profile
            _buildAppBar(),
            
            // Featured content - Hero section
            SliverToBoxAdapter(
              child: _buildFeaturedContent(),
            ),
            
            // Category selector
            SliverToBoxAdapter(
              child: _buildCategorySelector(),
            ),
            
            // Trending now section
            SliverToBoxAdapter(
              child: _buildContentSection(
                title: 'Trending Now',
                isLarge: false,
              ),
            ),
            
            // Popular movies section
            SliverToBoxAdapter(
              child: _buildContentSection(
                title: 'Popular Movies',
                isLarge: true,
              ),
            ),
            
            // Continue watching section
            SliverToBoxAdapter(
              child: _buildContentSection(
                title: 'Continue Watching',
                isLarge: false,
                showProgress: true,
              ),
            ),
            
            // Top rated section
            SliverToBoxAdapter(
              child: _buildContentSection(
                title: 'Top Rated',
                isLarge: false,
              ),
            ),
            
            // Spacing at the bottom for the nav bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 70,
      flexibleSpace: FlexibleSpaceBar(
        background: GlassmorphicContainer(
          width: double.infinity,
          height: 70,
          borderRadius: 0,
          blur: 10,
          alignment: Alignment.center,
          border: 0,
          linearGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.backgroundColor.withOpacity(0.9),
              AppTheme.backgroundColor.withOpacity(0.8),
            ],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.backgroundColor,
              AppTheme.backgroundColor,
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App logo
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: AppTheme.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'B',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'BeamBox',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  // Icons
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        color: AppTheme.textPrimary,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.cast),
                        color: AppTheme.textPrimary,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedContent() {
    // We'll replace this with the actual FeaturedContent widget later
    return Container(
      height: 500,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            AppTheme.backgroundColor.withOpacity(0.9),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (placeholder)
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.2),
              image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/800/1200'),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
          ),
          
          // Gradient overlay for better text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
          
          // Content information
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildTag('New'),
                      _buildTag('Sci-Fi'),
                      _buildTag('Action'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Title
                  const Text(
                    'The Future Beyond',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Description
                  Text(
                    'Experience the next evolution of entertainment with groundbreaking visuals and an immersive story.',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Buttons
                  Row(
                    children: [
                      // Play button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _navigateToDetails("the-future-beyond");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.play_arrow),
                          label: const Text(
                            'Play',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Info button
                      IconButton(
                        onPressed: () {
                          _navigateToDetails("the-future-beyond");
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.surfaceColor.withOpacity(0.8),
                          padding: const EdgeInsets.all(12),
                        ),
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      // Add to list button
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.surfaceColor.withOpacity(0.8),
                          padding: const EdgeInsets.all(12),
                        ),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Column(
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 3,
                    width: isSelected ? 30 : 0,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentSection({
    required String title,
    required bool isLarge,
    bool showProgress = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'View all',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Content row
        SizedBox(
          height: isLarge ? 240 : 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _navigateToDetails('content-$index');
                },
                child: Container(
                  width: isLarge ? 160 : 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppTheme.surfaceColor,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://picsum.photos/200/300?random=$index',
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: showProgress
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.only(bottom: 8),
                            width: isLarge ? 140 : 100,
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.3 + (index * 0.05),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80,
      borderRadius: 0,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 0,
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.backgroundColor.withOpacity(0.0),
          AppTheme.backgroundColor.withOpacity(0.8),
        ],
      ),
      borderGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.transparent,
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.textMuted,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline),
              activeIcon: Icon(Icons.play_circle),
              label: 'Coming Soon',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(String contentId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailsScreen(contentId: contentId),
      ),
    );
  }
} 