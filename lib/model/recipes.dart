import 'package:recieps_app/model/ingredients.dart';

class Recipe {
  List<Ingredient>? extendedIngredients;

  Recipe({
    this.extendedIngredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extendedIngredients':
          extendedIngredients?.map((e) => e.toJson()).toList(),
    };
  }
}
