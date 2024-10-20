import 'dart:convert';

class Cocktail{
  int id;
  String name;
  String category;
  String glass;
  String instructions;
  String imageUrl;
  bool alcoholic;

  Cocktail.fromJson(Map json):
        id=json['id'],
        name=json['name'],
        category=json['category'],
        glass=json['glass'],
        instructions=json['instructions'],
        imageUrl=json['imageUrl'],
        alcoholic=json['alcoholic'];

  Map mapa(){
    return {
      'id': id,
      'name': name,
      'category': category,
      'glass': glass,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'alcoholic': alcoholic,

    };
  }
}

class Ingredients{
  int id;
  String description;
  String type;
  int percentage;
  String imageUrl;

  Ingredients.fromJson(Map json):
      id=json['id'],
      description=json['description'],
      type=json['type'],
      percentage=json['percentage'],
      imageUrl=json['imageUrl'];

  Map mapa(){
      return {
          'id': id,
          'description': description,
          'type':type,
          'percentage':percentage,
          'imageUrl':imageUrl,
        };
      }

}
