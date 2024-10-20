import 'dart:convert';
import 'package:cocktail_app/dane/cocktails.dart';
import 'package:cocktail_app/dane/cocktails_api.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CocktailsList extends StatefulWidget {
  @override
  _CocktailsListState createState() => _CocktailsListState();
}

class _CocktailsListState extends State<CocktailsList> {
  static const _pageSize = 20;
  final PagingController<int, Cocktail> _pagingController = PagingController(firstPageKey: 1);

  List<Cocktail> allCocktails = []; // List to store all cocktails for searching

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

        allCocktails.addAll(newItems); // Add new cocktails to the list

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
        title: Text(
          'Cocktails',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24, // Large font size for title
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
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
        padding: const EdgeInsets.all(16.0),
        child: PagedGridView<int, Cocktail>(
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 16.0, // Horizontal space between items
            mainAxisSpacing: 16.0, // Vertical space between items
            childAspectRatio: 0.75, // Aspect ratio for image and text layout
          ),
          builderDelegate: PagedChildBuilderDelegate<Cocktail>(
            itemBuilder: (context, item, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/drugastrona',
                  arguments: item, // Przekazujemy obiekt 'Cocktail' jako argument
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image with circular border
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade300,
                          )
                        ],
                      image: DecorationImage(
                        image: NetworkImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0), // Space between image and text
                  // Title of the dish
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Font size for dish name
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
        return ListTile(
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/drugastrona',
                arguments: result,
              );
            },
            child: Text(result.name),
          ),
          leading: Image.network(
            result.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
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