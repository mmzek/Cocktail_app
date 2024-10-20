import 'dart:convert';
import 'package:cocktail_app/dane/cocktails.dart';
import 'package:cocktail_app/dane/cocktails_api.dart';
import 'package:flutter/material.dart';

class Drugastrona extends StatefulWidget {
  @override
  _DrugastronaState createState() => _DrugastronaState();
}

class _DrugastronaState extends State<Drugastrona> {
  List<Ingredients> ingredientsList = [];
  late final Cocktail cocktail;

  void getIngredientsfromApi() async {
    try {
      final response = await CocktailApi.getIngredients();

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['data'] != null) {
          setState(() {
            ingredientsList = (jsonData['data'] as List)
                .map((cos) => Ingredients.fromJson(cos))
                .toList();
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    getIngredientsfromApi();
  }
  
  @override
  Widget build(BuildContext context) {
    cocktail = ModalRoute .of(context)! .settings .arguments as Cocktail;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration( image: DecorationImage(image: NetworkImage(ingredientsList[index].imageUrl), fit: BoxFit.fill,),),

                ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                child: Text(cocktail.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
            ),
          ),
        ],
      )
    );
  }
  
}