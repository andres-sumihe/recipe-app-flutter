class Recipe {
  int recipeId;
  String recipeName;
  String recipePictureUrl;
  String description;
  int userId;
  int categoryId;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.recipePictureUrl,
    required this.description,
    required this.userId,
    required this.categoryId,
  });

  Recipe.fromMap(Map snapshot) :
        recipeId = snapshot['recipe_id'],
        recipeName = snapshot['recipe_name'],
        recipePictureUrl = snapshot['recipe_picture_url'],
        description = snapshot['description'],
        userId = snapshot['user_id'],
        categoryId = snapshot['category_id'];
        
  Map<String, dynamic> toJson() => {
        'recipe_id': recipeId,
        'recipe_name': recipeName,
        'recipe_picture_url': recipePictureUrl,
        'description': description,
        'user_id': userId,
        'category_id': categoryId,
      };
}
