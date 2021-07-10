import 'dart:convert';
import 'package:recipe_app/models/Grocery.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GroceriesService {

  static Future<List<Grocery>> getAllRecipeGroceries(int? recipeId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jwt = prefs.getString('jwt');
    String apiUrl = 'http://192.168.11.210:8080/api/grocery/getRecipeGroceries.php';
    final response = await http.post(Uri.parse(apiUrl),body: jsonEncode(
        <String, String>{'recipe_id': recipeId!.toString() ,'jwt': jwt!},
      ),);

    final data = jsonDecode(response.body);

    List<Grocery> groceries = [];
    
    for (var grocery in data['data']) {
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
