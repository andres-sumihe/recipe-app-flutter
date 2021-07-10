import 'dart:convert';
import 'package:recipe_app/models/CookingSteps.dart';
import 'package:http/http.dart' as http;

class CookingStepService {

  static Future<List<CookingStep>> getAllRecipeCookingSteps() async {
    String apiUrl = 'http://192.168.11.210:8080/api/cooking_steps/getRecipeCookingSteps.php';
    final response = await http.get(Uri.parse(apiUrl));

    final data = jsonDecode(response.body);

    List<CookingStep> cookingSteps = [];  
    
    for (var grocery in data['records']) {
      CookingStep recipe = new CookingStep(
        recipeId: int.parse(grocery['recipe_id']),
        cookingStepId: int.parse(grocery['cooking_steps_id']), 
        title: grocery['title'], 
        description: grocery['description'], 
        );

      cookingSteps.add(recipe);
      
    }

    return cookingSteps;
  }
}
