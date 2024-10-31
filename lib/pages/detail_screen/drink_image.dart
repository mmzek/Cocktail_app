import 'package:flutter/material.dart';

class DrinkImage extends StatelessWidget {
  const DrinkImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 40, left: 5),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/first_page');
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ],
    );
  }
}
