import 'package:recipe_app/models/CookingSteps.dart';
import 'package:recipe_app/network/service/cooking_steps_service.dart';
import 'package:flutter/cupertino.dart';


class CookingStepProvider extends ChangeNotifier {
  List<CookingStep>? cookingStepsData;
  List<CookingStep>? get getAllRecipeCookingSteps => cookingStepsData;

  void load(int recipeId) async {
    cookingStepsData = await CookingStepService.getAllRecipeCookingSteps(recipeId);

    notifyListeners();
  }
}