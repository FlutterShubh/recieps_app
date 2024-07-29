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
  List<Ingredient> favList = [];
  List<Ingredient> searchResults = [];
  bool loading = false;

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
    await loadFavs();
    notifyListeners();
  }

  addToFav(int index) async {
    final ingredient = recipe?.recipes.first.extendedIngredients?[index];
    if (ingredient != null) {
      ingredient.isFav = !ingredient.isFav;
      if (ingredient.isFav) {
        favList.add(ingredient);
      } else {
        favList.removeWhere((item) => item.id == ingredient.id);
      }
      await saveFavs();
      notifyListeners();
    }
  }

  removeFromFav(int index) async {
    final ingredient = favList[index];
    ingredient.isFav = false;
    favList.removeAt(index);
    await saveFavs();
    notifyListeners();
  }

  saveFavs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> favs = favList.map((ingredient) => jsonEncode(ingredient.toJson())).toList();
    await pref.setStringList('favList', favs);
  }

  loadFavs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? favs = pref.getStringList('favList');
    if (favs != null) {
      favList = favs.map((item) => Ingredient.fromJson(jsonDecode(item))).toList();
      for (var fav in favList) {
        final ingredient = recipe?.recipes.first.extendedIngredients?.firstWhere(
                (item) => item.id == fav.id);
        if (ingredient != null) {
          ingredient.isFav = true;
        }
      }
    }
    notifyListeners();
  }

  searchRecipes(String query) {
    loading = true;
    if (recipe != null) {
      searchResults = recipe!.recipes.first.extendedIngredients!.where((ingredients) {
        return ingredients.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      searchResults = [];
    }
    loading = false;
    notifyListeners();
  }
}
