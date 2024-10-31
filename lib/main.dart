import 'package:cocktail_app/pages/home_screen/home_screen.dart';
import 'package:cocktail_app/pages/detail_screen/detail_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CocktailsList(),
      routes:{
        '/first_page': (context) => const CocktailsList(),
        '/second_page': (context) => DetailScreen(),
      },
    );
  }
}
