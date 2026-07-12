import '../models/recipe.dart';

class RecipeService {
  static final List<Recipe> _recipes = [];

  List<Recipe> getAllRecipes() {
    return List.unmodifiable(_recipes);
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  void updateRecipe(String id, Recipe updatedRecipe) {
    final index = _recipes.indexWhere((r) => r.id == id);
    if (index != -1) {
      _recipes[index] = updatedRecipe;
    }
  }

  void deleteRecipe(String id) {
    _recipes.removeWhere((r) => r.id == id);
  }

  Recipe? getRecipeById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  bool get isEmpty => _recipes.isEmpty;
}
