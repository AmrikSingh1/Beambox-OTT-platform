import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../config/theme.dart';
import '../../player/screens/player_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String contentId;
  
  const DetailsScreen({
    super.key,
    required this.contentId,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // Mock data for demonstration
  final Map<String, dynamic> _contentDetails = {
    'the-future-beyond': {
      'title': 'The Future Beyond',
      'year': '2023',
      'duration': '2h 15m',
      'rating': '8.7',
      'genres': ['Sci-Fi', 'Action', 'Adventure'],
      'description': 'In a world where technology has surpassed human imagination, one person dares to question the boundaries between reality and virtual existence.',
      'cast': ['Emma Roberts', 'Michael B. Jordan', 'Zendaya', 'Pedro Pascal'],
      'director': 'Christopher Nolan',
      'thumbnailUrl': 'https://picsum.photos/800/450',
      'backdropUrl': 'https://picsum.photos/1920/1080',
      'seasons': 0, // 0 means it's a movie
      'odyseeUrl': 'https://odysee.com/@MovieGasm:d/deadpool-wolverine-avengers-secret-wars:f',
    },
  };

  Map<String, dynamic> get _details {
    // Return fake data if the content ID is not found
    if (!_contentDetails.containsKey(widget.contentId)) {
      return {
        'title': 'Sample Content ${widget.contentId}',
        'year': '2023',
        'duration': '1h 45m',
        'rating': '7.5',
        'genres': ['Drama', 'Thriller'],
        'description': 'This is a sample description for the content that was not found in our database.',
        'cast': ['Actor 1', 'Actor 2', 'Actor 3'],
        'director': 'Director Name',
        'thumbnailUrl': 'https://picsum.photos/800/450?random=1',
        'backdropUrl': 'https://picsum.photos/1920/1080?random=1',
        'seasons': 0,
        'odyseeUrl': 'https://ody.sh/m8c2h8re9U',
      };
    }
    
    return _contentDetails[widget.contentId];
  }

  void _playContent() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlayerScreen(
          videoUrl: 'https://ody.sh/m8c2h8re9U',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero backdrop
            _buildHeroSection(),
            
            // Content details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Metadata row
                  _buildMetadataRow(),
                  const SizedBox(height: 16),
                  
                  // Description
                  Text(
                    _details['description'],
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Cast section
                  _buildSectionTitle('Cast & Crew'),
                  const SizedBox(height: 12),
                  _buildCastList(),
                  const SizedBox(height: 24),
                  
                  // More like this
                  _buildSectionTitle('More Like This'),
                  const SizedBox(height: 12),
                  _buildSimilarContent(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _playContent,
        backgroundColor: AppTheme.primaryColor,
        label: const Text(
          'Play',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      children: [
        // Backdrop image
        Container(
          height: 450,
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppTheme.backgroundColor,
              ],
              stops: const [0.7, 1.0],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withOpacity(0.8),
                AppTheme.accentColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.movie,
              size: 80,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
        
        // Title and info overlay
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with animation
              Text(
                _details['title'],
                style: const TextStyle(
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
              )
                  .animate()
                  .fade(duration: 500.ms)
                  .slideY(
                    begin: 10,
                    end: 0,
                    duration: 500.ms,
                    curve: Curves.easeOutCubic,
                  ),
                  
              const SizedBox(height: 8),
              
              // Genres with animation
              Wrap(
                spacing: 8,
                children: (_details['genres'] as List<String>)
                    .map((genre) => _buildGenreChip(genre))
                    .toList(),
              )
                  .animate()
                  .fade(delay: 200.ms, duration: 500.ms)
                  .slideY(
                    begin: 10,
                    end: 0,
                    delay: 200.ms,
                    duration: 500.ms,
                    curve: Curves.easeOutCubic,
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenreChip(String genre) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        genre,
        style: TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildMetadataRow() {
    return Row(
      children: [
        // Year
        _buildMetadataItem(
          _details['year'],
          Icons.calendar_today_outlined,
        ),
        
        // Duration
        _buildMetadataItem(
          _details['duration'],
          Icons.timer_outlined,
        ),
        
        // Rating
        _buildMetadataItem(
          'IMDb ${_details['rating']}',
          Icons.star_outline,
          color: Colors.amber,
        ),
        
        // HD quality
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.textMuted),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'HD',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetadataItem(String text, IconData icon, {Color? color}) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color ?? AppTheme.textMuted,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCastList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (_details['cast'] as List<String>).length,
        itemBuilder: (context, index) {
          final actor = (_details['cast'] as List<String>)[index];
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                // Actor avatar
                ClipOval(
                  child: Container(
                    width: 60,
                    height: 60,
                    color: AppTheme.cardColor,
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white54,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Actor name
                Text(
                  actor,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSimilarContent() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 120,
              height: 180,
              color: AppTheme.surfaceColor,
              child: const Center(
                child: Icon(
                  Icons.movie,
                  color: Colors.white54,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 