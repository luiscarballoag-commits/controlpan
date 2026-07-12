/// =======================================================
/// CONTROLPAN
/// Modelo: recipe.dart
/// Descripción:
/// Modelo de una receta de producción.
/// =======================================================

import 'recipe_ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String description;
  final List<RecipeIngredient> ingredients;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
  });

  double get totalQuantity {
    double total = 0;

    for (final ingredient in ingredients) {
      total += ingredient.quantity;
    }

    return total;
  }
}
