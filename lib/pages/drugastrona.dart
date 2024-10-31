import 'dart:convert';
import 'package:cocktail_app/dane/cocktails.dart';
import 'package:cocktail_app/dane/cocktails_api.dart';
import 'package:flutter/material.dart';

class Drugastrona extends StatefulWidget {
  @override
  _DrugastronaState createState() => _DrugastronaState();
}

class _DrugastronaState extends State<Drugastrona> {
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
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cocktail.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    cocktail.name,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      cocktail.category,
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Text(
                              cocktail.glass,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Text(
                              cocktail.alcoholic ? "Alcoholic" : "Non-alcoholic",
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      cocktail.instructions,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cocktail.ingredients?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Ingredient ingredient = cocktail.ingredients![index];
                      return Column(
                        children: [
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ingredient.imageUrl != null
                                          ? NetworkImage(ingredient.imageUrl!)
                                          : const AssetImage('images/pytajnik-kubek.jpg') as ImageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey[200],
                                ),
                                child: Center(
                                  child: Text(
                                    ingredient.name,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(ingredient.description ?? "", style: const TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
                          ),
                        ],
                      );


                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}