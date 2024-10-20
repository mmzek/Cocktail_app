import 'package:http/http.dart' as http;
import 'dart:async';

class CocktailApi {
  // Modyfikacja metody getCocktails, aby obsługiwała paginację.
  static Future<http.Response> getCocktails(int page, int limit) {
    // Dodajemy parametry page i limit do URL-a
    final url = Uri.parse("https://cocktails.solvro.pl/api/v1/cocktails?page=$page&limit=$limit");

    // Zwracamy odpowiedź z API
    return http.get(url);
  }
}
//czemu trzeba użyć metody parse(bez niej nie działa)?????????????????????
//obstawiam ze metoda parse, parsuje (dzieli) jak sama nazwa wskazuje wiec moze chodzi o to zeby ten uri ładował dane w częsciach a nie w calosci