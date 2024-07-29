import 'package:recieps_app/model/recipes.dart';

class RecipesModel {
  List<Recipe> recipes;

  RecipesModel({
    required this.recipes,
  });

  factory RecipesModel.fromJson(Map<String, dynamic> json) {
    return RecipesModel(
      recipes: List<Recipe>.from(json['recipes'].map((x) => Recipe.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipes': recipes.map((x) => x.toJson()).toList(),
    };
  }
}