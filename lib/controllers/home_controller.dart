import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recieps_app/model/ingredients.dart';
import 'package:recieps_app/model/recipeModel.dart';
import 'package:recieps_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/recipes.dart';

class HomeController extends ChangeNotifier {
  RecipesModel? recipe;
  final ApiService _apiService = ApiService();
  List<String> data = [];
  List<Ingredient> favList = [];
  List<Ingredient> searchList = [];




  HomeController() {
    getAllRecipes();
  }

  getAllRecipes() async {
    final Response response = await _apiService.getRecipes();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? all = pref.getString("all");
    if (all != null) {
      recipe = RecipesModel.fromJson(jsonDecode(all));
    } else {
      await pref.setString("all", jsonEncode(response.data as Map));
      final String? all = pref.getString("all");
      recipe = RecipesModel.fromJson(jsonDecode(all ?? ""));
    }
    notifyListeners();
  }

  addToFav(int index) async {
    if (recipe?.recipes.first.extendedIngredients?[index].isFav == true) {
      recipe?.recipes.first.extendedIngredients?[index].isFav = false;
    } else {
      recipe?.recipes.first.extendedIngredients?[index].isFav = true;
    }
    notifyListeners();

  }

  removeFromFav(int index) async {
    print(favList[index].isFav);
    favList[index].isFav = false;
    favList.removeAt(index);
   await getAllFavs();

    notifyListeners();
  }

 getAllFavs() async {
    if (recipe?.recipes.first.extendedIngredients != null) {
      int i = 0;
      while (i < recipe!.recipes.first.extendedIngredients!.length) {
        if (recipe!.recipes.first.extendedIngredients![i].isFav &&
            !favList.contains(recipe!.recipes.first.extendedIngredients![i])) {
          favList.add(recipe!.recipes.first.extendedIngredients![i]);
        }
        i++;
      }
    }
  }
}
