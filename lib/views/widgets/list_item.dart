import 'package:flutter/material.dart';
import 'package:recieps_app/controllers/home_controller.dart';
import 'package:recieps_app/model/ingredients.dart';
import 'package:recieps_app/model/recipes.dart';

class ListItem extends StatelessWidget {
  final int index;
  final Ingredient recipe;
  final HomeController homeController;
  const ListItem(
      {super.key, required this.index, required this.recipe, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name ?? "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                    "Price : ${recipe.amount ?? ""} USD"),
              ],
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () async {
                      await homeController.addToFav(index);
                    },
                    child: homeController.recipe?.recipes.first
                                .extendedIngredients![index].isFav ==
                            true
                        ? const Text("Remove from Favorite")
                        : const Text("Add to Favorite"))
              ];
            },
          ),
        ],
      ),
    );
    ;
  }
}
