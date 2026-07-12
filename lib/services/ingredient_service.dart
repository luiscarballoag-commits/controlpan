import '../models/ingredient_catalog.dart';

class IngredientService {
  static final List<IngredientCatalog> _ingredients = [];

  List<IngredientCatalog> getAllIngredients() {
    return List.unmodifiable(_ingredients);
  }

  void addIngredient(IngredientCatalog ingredient) {
    _ingredients.add(ingredient);
  }

  void updateIngredient(
    String id,
    IngredientCatalog updatedIngredient,
  ) {
    final index = _ingredients.indexWhere((i) => i.id == id);

    if (index != -1) {
      _ingredients[index] = updatedIngredient;
    }
  }

  void deleteIngredient(String id) {
    _ingredients.removeWhere((i) => i.id == id);
  }

  IngredientCatalog? getIngredientById(String id) {
    try {
      return _ingredients.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }

  List<IngredientCatalog> search(String text) {
    if (text.isEmpty) {
      return getAllIngredients();
    }

    return _ingredients.where((ingredient) {
      return ingredient.name
          .toLowerCase()
          .contains(text.toLowerCase());
    }).toList();
  }

  bool get isEmpty => _ingredients.isEmpty;
}
