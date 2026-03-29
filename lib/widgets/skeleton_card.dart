import 'package:flutter/material.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE PLACEHOLDER
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// TEXT LINE 1
          Container(
            height: 14,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey[300],
          ),

          const SizedBox(height: 8),

          /// TEXT LINE 2
          Container(
            height: 14,
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey[300],
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}