import 'package:cocktail_app/pages/firstpage.dart';
import 'package:cocktail_app/pages/drugastrona.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//funkcja runApp bierze pierwszy widget czyli klasę MyApp i umieszcza ją jako korzeń drzewa, początek naszej aplikacji
//rodzic: StatelessWidget dziecko: MyApp
// tworzymy klasę MyApp, extends oznacza to mniej więcej tyle co class MyApp :public StatelessWidget
class MyApp extends StatelessWidget {
  //super jest to słowoo kluczowe dzieki ktoremu MyApp moze uzywac metod i konstruktora Statelesswidget (rodzica)
  //tworzymy widget MyApp który jest zadany przed kompilacją i posiada on klucz który jest kluczem opcjonalnym (można stworzyc MyApp bez klucza) a jesli zostanie podana wartosc key to bedzie przekazana do konstruktora w StatelessWidget dzieki super
  const MyApp({super.key});
  @override
  //metoda build jest metodą funkcji StatelessWidget z której dziedziczy MyApp, wiec zeby byla ona w MyApp trzeba ja nadpisac
//metoda build typu Widget
  //BuildContext który nazwaliśmy context jest to " ścieżka" która dostarcza widgetom informacje w którym miejscu układanki się znajdują
  Widget build(BuildContext context) {
    return MaterialApp( // metoda build zwraca typ Widget, zatem MateriaApp jest typu Widget
      debugShowCheckedModeBanner: false,
      home: CocktailsList(), //ustawiamy ekran startowy homepage jako Cocktails list
      routes:{
        '/pierwszastrona': (context) => CocktailsList(),
        '/drugastrona': (context) => Drugastrona(),
      },
    );
  }
}
