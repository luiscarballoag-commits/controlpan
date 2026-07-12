/// =======================================================
/// CONTROLPAN
/// Modelo: recipe_ingredient.dart
/// Descripción:
/// Ingrediente utilizado dentro de una receta.
/// =======================================================

import 'ingredient_catalog.dart';

class RecipeIngredient {
  final IngredientCatalog ingredient;
  final double quantity;

  const RecipeIngredient({
    required this.ingredient,
    required this.quantity,
  });

  String get unit => ingredient.unit;

  String get name => ingredient.name;
}
