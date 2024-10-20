import 'package:flutter/material.dart';
import 'package:cocktail_app/dane/cocktails.dart';

class Drugastrona extends StatelessWidget {
  const Drugastrona({super.key});

  @override
  Widget build(BuildContext context) {

    //kopiuj wklej
    final Cocktail cocktail = ModalRoute.of(context)!.settings.arguments as Cocktail;

    return Scaffold(
      appBar: AppBar(
        title: Text(cocktail.name, style:  TextStyle(
          color: Colors.black,
          fontSize: 24, // Large font size for title
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.white,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(cocktail.imageUrl),
            SizedBox(height: 16),
            Center(child: Text(
              ' ${cocktail.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),),
            SizedBox(height: 8),
            Text(
              'Glass type: ${cocktail.glass}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Instructions: ${cocktail.instructions}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
    );
  }
}