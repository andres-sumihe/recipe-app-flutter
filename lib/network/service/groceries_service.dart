import 'dart:convert';
import 'package:recipe_app/models/Grocery.dart';
import 'package:http/http.dart' as http;

class GroceriesService {

  static Future<List<Grocery>> getAllRecipeGroceries() async {
    String apiUrl = 'http://192.168.11.210:8080/api/grocery/getRecipeGroceries.php';
    final response = await http.get(Uri.parse(apiUrl));

    final data = jsonDecode(response.body);

    List<Grocery> groceries = [];
    
    for (var grocery in data['records']) {
      Grocery recipe = new Grocery(
        recipeId: int.parse(grocery['recipe_id']),
        groceriesId: int.parse(grocery['groceries_id']), 
        groceriesName: grocery['groceries_name'], 
        groceriesQuantity: grocery['groceries_quantity'], 
        );

      groceries.add(recipe);
      
    }

    return groceries;
  }
}
