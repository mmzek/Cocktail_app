import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  const DrinkCard({
    super.key, required this.title, required this.image,
  });
  final String title;
  final String image;
  @override
  Widget build(BuildContext context,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 5,
              ),
              BoxShadow(
                color: Colors.grey.shade300,
              )
            ],
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8.0), // Space between image and text
        // Title of the dish
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16, // Font size for dish name
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
