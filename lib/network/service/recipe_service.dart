import 'dart:convert';
import 'package:recipe_app/models/Recipe.dart';
import 'package:http/http.dart' as http;

class RecipeService {

  static Future<List<Recipe>> getAllRecipe() async {
    String apiUrl = 'http://192.168.11.210:8080/api/recipe/read.php';
    final response = await http.get(Uri.parse(apiUrl));

    print(response.body);
    final data = jsonDecode(response.body);
    print(data['records']);

    List<Recipe> recipes = [];
    
    for (var recipe_item in data['records']) {
      Recipe recipe = new Recipe(
        recipeId: int.parse(recipe_item['recipe_id']),
        recipeName: recipe_item['recipe_name'], 
        recipePictureUrl: recipe_item['picture_recipe_url'], 
        description: recipe_item['description'], 
        userId: int.parse(recipe_item['user_id']), 
        categoryId: int.parse(recipe_item['category_id'])
        );

      recipes.add(recipe);
      
    }

    return recipes!;
  }
}
