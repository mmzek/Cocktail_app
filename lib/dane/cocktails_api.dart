import 'package:http/http.dart' as http;
import 'dart:async';

class CocktailApi {
  static Future<http.Response> getCocktails(int page, int limit) {
    final url = Uri.parse("https://cocktails.solvro.pl/api/v1/cocktails?page=$page&limit=$limit");
    return http.get(url);
  }
  static Future<http.Response> getCocktail(int id) {
    final url = Uri.parse("https://cocktails.solvro.pl/api/v1/cocktails/$id");
    return http.get(url);
  }
  static Future<http.Response> getIngredients() {
    final url = Uri.parse("https://cocktails.solvro.pl/api/v1/ingredients");
        return http.get(url);
  }
}

