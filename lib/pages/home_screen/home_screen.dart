import 'dart:convert';
import 'package:cocktail_app/dane/cocktails.dart';
import 'package:cocktail_app/dane/cocktails_api.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'drink_card.dart';

class CocktailsList extends StatefulWidget {
  const CocktailsList({super.key});

  @override
  _CocktailsListState createState() => _CocktailsListState();
}

class _CocktailsListState extends State<CocktailsList> {
  static const _pageSize = 20;
  final PagingController<int, Cocktail> _pagingController =
      PagingController(firstPageKey: 1);

  List<Cocktail> allCocktails = [];

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await CocktailApi.getCocktails(pageKey, _pageSize);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        List<Cocktail> newItems = (jsonData['data'] as List)
            .map((item) => Cocktail.fromJson(item))
            .toList();

        allCocktails.addAll(newItems);

        final int currentPage = jsonData['meta']['currentPage'];
        final int lastPage = jsonData['meta']['lastPage'];

        final isLastPage = currentPage == lastPage;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      } else {
        _pagingController.error = 'Error: ${response.statusCode}';
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cocktails',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(allCocktails),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: PagedGridView<int, Cocktail>(
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.9,
          ),
          builderDelegate: PagedChildBuilderDelegate<Cocktail>(
            itemBuilder: (context, item, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/second_page',
                  arguments:
                      item,
                );
              },
              child: DrinkCard(title: item.name, image: item.imageUrl),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Cocktail> cocktails;

  CustomSearchDelegate(this.cocktails);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Cocktail> matchQuery = [];
    for (var cocktail in cocktails) {
      if (cocktail.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(cocktail);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/second_page',
                arguments: result,
              );
            },
            title: Text(result.name),
            leading: Image.network(
              result.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Cocktail> matchQuery = [];
    for (var cocktail in cocktails) {
      if (cocktail.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(cocktail);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
        );
      },
    );
  }
}
