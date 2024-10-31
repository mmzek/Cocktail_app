import 'package:flutter/material.dart';
import 'package:cocktail_app/dane/cocktails.dart';

class DrinkDetails extends StatelessWidget {
  const DrinkDetails({
    super.key,
    required this.cocktail,
  });

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          TwoGreyContainers(
            text1: cocktail.glass,
            text2: cocktail.alcoholic ? "Alcoholic" : "Non-alcoholic",
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
                  IngredientImage(
                    image: ingredient.imageUrl,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                    child: Row(
                      children: [
                        const Spacer(flex: 1,),
                        Expanded(
                          flex: 17,
                          child: GreyContainer(text: ingredient.name),
                        ),
                        const Spacer(flex:1,)
                      ],
                    ),
                  ),
                  TwoGreyContainers(
                    text1: ingredient.percentage == null
                        ? "Unknown %"
                        : "${ingredient.percentage}%",
                    text2: ingredient.alcohol ? "Alcoholic" : "Non-alcoholic",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ingredient.description ?? "",
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class IngredientImage extends StatelessWidget {
  const IngredientImage({
    super.key,
    required this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image != null
              ? NetworkImage(image!)
              : const AssetImage('images/pytajnik-kubek.jpg') as ImageProvider,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class GreyContainer extends StatelessWidget {
  const GreyContainer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}

class TwoGreyContainers extends StatelessWidget {
  const TwoGreyContainers({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 8,
          child: GreyContainer(text: text1),
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 8,
          child: GreyContainer(text: text2),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
