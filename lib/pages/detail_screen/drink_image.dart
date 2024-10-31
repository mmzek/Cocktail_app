import 'package:flutter/material.dart';

class DrinkImage extends StatelessWidget {
  const DrinkImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}