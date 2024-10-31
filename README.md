# 🍹 Cocktail App

`Cocktail app` to intuicyjna aplikacja mobilna stworzona we Flutterze, umożliwiająca łatwe i przyjemne odkrywanie przepisów na drinki. Każdy koktajl zawiera szczegółowe informacje: zdjęcie, instrukcję przygotowania, odpowiedni typ szkła, zawartość alkoholu oraz pełną listę składników i ich właściwości. Dodatkowo, aplikacja oferuje możliwość wyszukiwania drinków po nazwie, co pozwala użytkownikom szybko odnaleźć ulubione przepisy lub odkryć nowe inspiracje.

## 🎯 Kluczowe Funkcje

- **Przeglądanie koktajli**
  
     Lista drinków przedstawiona jest w formie siatki z eleganckimi miniaturami, które umożliwiają łatwą nawigację. Każda miniatura zawiera nazwę oraz zdjęcie koktajlu.

  <img src="https://github.com/user-attachments/assets/dc2d81af-99b0-47ba-a38e-76da06a700f2" width="18%" style="margin-right: 20px;"/> <img src="https://github.com/user-attachments/assets/fe256ca5-f691-44d4-890b-a08e9648077f" width="18%" style="margin-left: 10px;"/>

- **Wyświetlanie szczegółów**:
  
    Każdy przepis koktajlu to dedykowana strona, gdzie znajdziesz:
    - Pełną listę składników ze zdjęciami, opisami i dodatkowymi informacjami.
    - Instrukcje idealne dla każdego, kto chce odwzorować drink w domu.
    - Typ szkła oraz informację o statusie alkoholowym koktajlu.
    - Zdjęcie końcowe napoju.

  <img src="https://github.com/user-attachments/assets/e350562a-e61d-448f-a110-aee2cc47790c" width="18%" style="margin-right: 10px;"/> <img src="https://github.com/user-attachments/assets/7466e872-1797-46c6-b7ad-09cd67d9e5e6" width="18%" style="margin-left: 10px;"/>

- **Wyszukiwanie po nazwie**:
  
    Funkcja wyszukiwania pozwala szybko znaleźć koktajl po jego nazwie.

  <img src="https://github.com/user-attachments/assets/02e21fa9-5086-4d02-8563-89f0bb2c68c3" width="18%" style="margin-top: 10px;"/>

## 🛠 Technologie i Biblioteki
- **`Flutter`**: Framework użyty do budowy aplikacji, zapewniający wsparcie na urządzeniach mobilnych i tabletach.
- **`http`**: Pakiet do obsługi zapytań HTTP, umożliwiający komunikację z API koktajli oraz pobieranie danych o drinkach.
- **`infinite_scroll_pagination`**: Biblioteka zarządzająca stronicowaniem z przewijaniem, umożliwiająca płynne ładowanie drinków na liście bez przeładowywania całej strony.
  
## 📂 Struktura Projektu
### Główne Pliki i Moduły
- **[home_screen.dart](lib/pages/home_screen/home_screen.dart)**
  
    Główna strona aplikacji, zawiera widok siatki drinków z miniaturami. Obsługuje wyszukiwanie według nazw oraz paginację, co pozwala na ładowanie drinków w porcjach i przeglądanie drinków w sposób ciągły przy użyciu Infinite scroll.
- **[drink_details.dart](lib/pages/detail_screen/drink_details.dart)**
  
   Strona szczegółów drinka, zawierająca pełną listę składników wraz ze zdjęciami, opisami i właściwościami oraz instrukcje wykonania koktajlu, zdjęcie, typ szkła i status alkoholowy.
- **[cocktails.dart](lib/dane/cocktails.dart)**
  
    Plik zawiera modele danych Cocktail oraz Ingredient, które reprezentują strukturę danych drinka i jego składników.
- **[cocktails_api.dart](lib/api/cocktails_api.dart)**
  
    Klasa CocktailApi obsługuje komunikację z zewnętrznym API, które dostarcza informacje o drinkach. Zawiera metody do pobierania listy koktajli, jak i szczegółowych informacji o poszczególnych drinkach.
- **[drink_image.dart](lib/pages/detail_screen/drink_image.dart)**
  
    Komponent odpowiedzialny za wyświetlanie zdjęcia drinka z opcją nawigacji.
- **[drink_card.dart](lib/pages/home_screen/drink_card.dart)**
  
    Miniatura wyświetlana w siatce na stronie głównej.

## 🌱 Rozwój
- **Dodatkowe Wyszukiwanie**  
  Ulepszone wyszukiwanie według składników i kategorii, np. drinki bezalkoholowe lub bazujące na danym alkoholu.
- **Ulubione**  
  Dodanie możliwości zapisywania ulubionych drinków, co ułatwi dostęp do przepisów najczęściej wybieranych przez użytkowników.
- **Rekomendacje**  
  System rekomendacji drinków oparty na wcześniejszych wyszukiwaniach użytkownika.
