class CookingStep {
  int cookingStepId;
  String title;
  String description;
  int recipeId;

  CookingStep({
    required this.cookingStepId,
    required this.title,
    required this.description,
    required this.recipeId,
  });

  CookingStep.fromMap(Map snapshot) :
        cookingStepId = snapshot['cooking_steps_id'],
        title = snapshot['name'],
        description = snapshot['description'],
        recipeId = snapshot['recipe_id'];
        
  Map<String, dynamic> toJson() => {
        'cooking_steps_id': cookingStepId,
        'name': title,
        'description': description,
        'recipe_id': recipeId,
      };
}
