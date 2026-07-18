import 'package:hive/hive.dart';

import 'recipe_ingredient.dart';

part 'recipe.g.dart';

@HiveType(typeId: 4)
class Recipe extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<RecipeIngredient> ingredients;

  Recipe({
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

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    List<RecipeIngredient>? ingredients,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
