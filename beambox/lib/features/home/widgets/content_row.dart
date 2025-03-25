import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../config/theme.dart';
import '../../../models/content_item.dart';
import 'content_card.dart';

class ContentRow extends StatelessWidget {
  final String title;
  final List<ContentItem> items;
  final Function(ContentItem) onItemTap;
  
  const ContentRow({
    super.key,
    required this.title,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Content scroll row
        SizedBox(
          height: 180,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ContentCard(
                  item: items[index],
                  onTap: () => onItemTap(items[index]),
                )
                .animate(delay: Duration(milliseconds: 100 * index))
                .fadeIn(duration: 300.ms, curve: Curves.easeOutQuad)
                .slideX(begin: 0.2, end: 0),
              );
            },
          ),
        ),
      ],
    );
  }
} 