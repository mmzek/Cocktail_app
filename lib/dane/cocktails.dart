import 'dart:convert';

class Cocktail{
  int id;
  String name;
  String category;
  String glass;
  String instructions;
  String imageUrl;
  bool alcoholic;

//Konstruktor tworzy obiekty o typie mapa i nazwie json
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
//osobna klasa