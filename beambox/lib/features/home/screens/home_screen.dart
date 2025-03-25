import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../config/theme.dart';
import '../../../models/content_item.dart';
import '../widgets/category_selector.dart';
import '../widgets/featured_content.dart';
import '../widgets/content_row.dart';
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

  // Sample content items - In a real app, this would come from a repository or API
  late List<ContentItem> _trendingItems;
  late List<ContentItem> _popularMovies;
  late List<ContentItem> _continueWatching;
  late List<ContentItem> _topRated;
  late ContentItem _featuredItem;

  @override
  void initState() {
    super.initState();
    _initializeContent();
  }

  void _initializeContent() {
    // Featured content
    _featuredItem = ContentItem(
      id: 'featured-1',
      title: 'The Future Beyond',
      description: 'Experience the next evolution of entertainment with groundbreaking visuals and an immersive story.',
      imageUrl: 'https://picsum.photos/800/1200',
      tags: ['New', 'Sci-Fi', 'Action'],
      rating: 4.8,
      duration: '2h 15m',
      releaseYear: '2023',
      isFeatured: true,
      category: 'Movies',
      videoUrl: 'https://odysee.com/example'
    );

    // Generate sample content for different sections
    _trendingItems = _generateSampleItems(10, 'trending');
    _popularMovies = _generateSampleItems(10, 'popular');
    _continueWatching = _generateSampleItems(10, 'continue');
    _topRated = _generateSampleItems(10, 'top');
  }

  List<ContentItem> _generateSampleItems(int count, String prefix) {
    return List.generate(count, (index) {
      return ContentItem(
        id: '$prefix-$index',
        title: 'Content ${index + 1}',
        description: 'This is a sample description for content ${index + 1}.',
        imageUrl: 'https://picsum.photos/200/300?random=$index',
        tags: ['Tag1', 'Tag2'],
        rating: 3.5 + (index % 20) / 10,
        duration: '${1 + index % 3}h ${index * 10 % 60}m',
        releaseYear: '${2020 + index % 4}',
        category: _categories[index % _categories.length],
        videoUrl: 'https://odysee.com/example'
      );
    });
  }

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
              child: FeaturedContent(
                title: _featuredItem.title,
                description: _featuredItem.description,
                imageUrl: _featuredItem.imageUrl,
                tags: _featuredItem.tags,
                onPlay: () => _navigateToDetails(_featuredItem.id),
                onInfo: () => _navigateToDetails(_featuredItem.id),
              ),
            ),
            
            // Category selector
            SliverToBoxAdapter(
              child: CategorySelector(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            ),
            
            // Trending now section
            SliverToBoxAdapter(
              child: ContentRow(
                title: 'Trending Now',
                items: _trendingItems,
                onItemTap: (item) => _navigateToDetails(item.id),
              ),
            ),
            
            // Popular movies section
            SliverToBoxAdapter(
              child: ContentRow(
                title: 'Popular Movies',
                items: _popularMovies,
                onItemTap: (item) => _navigateToDetails(item.id),
              ),
            ),
            
            // Continue watching section
            SliverToBoxAdapter(
              child: ContentRow(
                title: 'Continue Watching',
                items: _continueWatching,
                onItemTap: (item) => _navigateToDetails(item.id),
              ),
            ),
            
            // Top rated section
            SliverToBoxAdapter(
              child: ContentRow(
                title: 'Top Rated',
                items: _topRated,
                onItemTap: (item) => _navigateToDetails(item.id),
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