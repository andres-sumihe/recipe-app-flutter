import 'package:recipe_app/models/Grocery.dart';
import 'package:recipe_app/network/service/groceries_service.dart';
import 'package:flutter/cupertino.dart';


class GroceriesProvider extends ChangeNotifier {
  List<Grocery>? groceryData;
  List<Grocery>? get getAllRecipe => groceryData;

  void load(int recipeId) async {
    groceryData = await GroceriesService.getAllRecipeGroceries(recipeId);

    notifyListeners();
  }
}