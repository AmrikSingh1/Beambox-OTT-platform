class ContentItem {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final List<String> tags;
  final double rating;
  final String duration;
  final String releaseYear;
  final bool isFeatured;
  final String category;
  final String videoUrl;

  ContentItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.tags,
    required this.rating,
    required this.duration,
    required this.releaseYear,
    this.isFeatured = false,
    required this.category,
    required this.videoUrl,
  });

  // Factory method to create from JSON
  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      tags: List<String>.from(json['tags']),
      rating: json['rating'] as double,
      duration: json['duration'] as String,
      releaseYear: json['releaseYear'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
      category: json['category'] as String,
      videoUrl: json['videoUrl'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'tags': tags,
      'rating': rating,
      'duration': duration,
      'releaseYear': releaseYear,
      'isFeatured': isFeatured,
      'category': category,
      'videoUrl': videoUrl,
    };
  }
} 