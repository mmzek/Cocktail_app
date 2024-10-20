import 'dart:convert';
import 'package:cocktail_app/dane/cocktails.dart';
import 'package:cocktail_app/dane/cocktails_api.dart';
import 'package:flutter/material.dart';

class Drugastrona extends StatefulWidget {
  @override
  _DrugastronaState createState() => _DrugastronaState();
}

class _DrugastronaState extends State<Drugastrona> {
  // we will store cocktail object passed from the first page as an argument here
  // it is late variable as we cannot initialize it here yet (we don't have context)
  late Cocktail cocktailFromArguments;
  // we will store full cocktail object (with ingredients) here
  // it is nullable variable as we might never get it from the server (due to network issues)
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
  // we use didChangeDependencies to extract the argument (Cocktail)
  // and call getCocktailFromAPI
  // didChangeDependencies method is called (also) after initState but we do have context here
  // (we don't have context yet in initState)
  @override
  void didChangeDependencies() {
    cocktailFromArguments = ModalRoute.of(context)!.settings.arguments as Cocktail;
    getCocktailFromAPI(cocktailFromArguments.id);
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    // use elvis operator - we prefer to display cocktail with ingredients but
    // if it is not there yet or we couldn't get it from API then fallback to
    // cocktailFromArgument (the one without ingredients inside)
    Cocktail cocktail = cocktailWithIngredients ?? cocktailFromArguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration( image: DecorationImage(image: NetworkImage(cocktail.imageUrl), fit: BoxFit.fill,),),

            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  Text(cocktail.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(cocktail.category,style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                  Row(
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex:8,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.grey[200]),
                          child: Center(child: Text(cocktail.glass, style: TextStyle(fontSize: 15),),),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.grey[200]),
                          child: Center(child: Text(
                            cocktail.alcoholic ? "Alcoholic" : "Non-alcoholic",
                            style: TextStyle(fontSize: 15),),),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                  Text(cocktail.instructions, style: TextStyle(fontSize: 15),),

                  // add a list of ingredients
                  Expanded(
                    child:
                      ListView.builder(
                          itemCount: cocktail.ingredients?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            Ingredient ingredient = cocktail.ingredients![index];
                            return Container(
                              height: 50,
                              child: Text(ingredient.name, style: TextStyle(fontSize: 15),)
                            );
                          }
                      )
                  ),



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
