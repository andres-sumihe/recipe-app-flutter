class Grocery {
  int groceriesId;
  String groceriesName;
  String groceriesQuantity;
  int recipeId;

  Grocery({
    required this.groceriesId,
    required this.groceriesName,
    required this.groceriesQuantity,
    required this.recipeId,
  });

  Grocery.fromMap(Map snapshot) :
        groceriesId = snapshot['groceries_id'],
        groceriesName = snapshot['groceries_name'],
        groceriesQuantity = snapshot['groceries_quantity'],
        recipeId = snapshot['recipe_id'];
        
  Map<String, dynamic> toJson() => {
        'groceries_id': groceriesId,
        'groceries_name': groceriesName,
        'groceries_quantity': groceriesQuantity,
        'recipe_id': recipeId,
      };
}
