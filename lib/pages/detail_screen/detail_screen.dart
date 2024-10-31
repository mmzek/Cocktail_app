import 'dart:convert';
import 'package:cocktail_app/dane/cocktails.dart';
import 'package:cocktail_app/dane/cocktails_api.dart';
import 'package:flutter/material.dart';

import 'drink_details.dart';
import 'drink_image.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Cocktail cocktailFromArguments;
  Cocktail? cocktailWithIngredients;

  void getCocktailFromAPI(int id) async {
    try {
      final response = await CocktailApi.getCocktail(id);

      if (response.statusCode == 200) {
        var jsonData = await json.decode(response.body);
        if (jsonData['data'] != null) {
          setState(() {
            cocktailWithIngredients = Cocktail.fromJson(jsonData['data']);
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void didChangeDependencies() {
    cocktailFromArguments = ModalRoute.of(context)!.settings.arguments as Cocktail;
    getCocktailFromAPI(cocktailFromArguments.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Cocktail cocktail = cocktailWithIngredients ?? cocktailFromArguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DrinkImage(image: cocktail.imageUrl),
            DrinkDetails(cocktail: cocktail),
          ],
        ),
      ),
    );
  }
}



