import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/network/service/recipe_service.dart';
import 'package:flutter/cupertino.dart';


class RecipeProvider extends ChangeNotifier {
  List<Recipe>? recipeData;
  List<Recipe>? get getAllRecipe => recipeData;

  void load() async {
    recipeData = await RecipeService.getAllRecipe();

    notifyListeners();
  }
}