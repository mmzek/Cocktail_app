import 'dart:convert';
import 'dart:ffi';

class Cocktail{
  int id;
  String name;
  String category;
  String glass;
  String instructions;
  String imageUrl;
  bool alcoholic;
  List<Ingredient>? ingredients;


  Cocktail.fromJson(Map json):
        id = json['id'],
        name = json['name'],
        category = json['category'],
        glass = json['glass'],
        instructions = json['instructions'],
        imageUrl = json['imageUrl'],
        alcoholic = json['alcoholic'],
        ingredients = (json['ingredients'] as List?)?.map(
            (ingredient) => Ingredient.fromJson(ingredient)
        ).toList();

  Map mapa(){
    return {
      'id': id,
      'name': name,
      'category': category,
      'glass': glass,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'alcoholic': alcoholic,
      'ingredients': ingredients
    };
  }
}

class Ingredient{
  int id;
  String name;
  String? description;
  bool alcohol;
  String? type;
  int? percentage;
  String? imageUrl;
  String measure;

  Ingredient.fromJson(Map json):
    id = json['id'],
    name = json['name'],
    description = json['description'],
    alcohol = json['alcohol'],
    type = json['type'],
    percentage = json['percentage'],
    imageUrl = json['imageUrl'],
    measure = json['measure'];

  Map map(){
      return {
          'id': id,
          'name': name,
          'description': description,
          'alcohol': alcohol,
          'type': type,
          'percentage': percentage,
          'imageUrl': imageUrl,
          'measure': measure
        };
      }

}
