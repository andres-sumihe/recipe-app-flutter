import 'dart:convert';
import 'package:recipe_app/models/CookingSteps.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CookingStepService {
  static Future<List<CookingStep>> getAllRecipeCookingSteps(int? recipeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jwt = prefs.getString('jwt');
    String apiUrl =
        'http://192.168.11.210:8080/api/cooking_steps/getRecipeCookingSteps.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(
        <String, String>{'recipe_id': recipeId!.toString() ,'jwt': jwt!},
      ),
    );

    final data = jsonDecode(response.body);

    List<CookingStep> cookingSteps = [];

    for (var grocery in data['data']) {
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
