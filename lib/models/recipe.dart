class Recipe {
  final String id;
  final String name;
  final String category;
  final double pieceWeight;
  final List<RecipeIngredient> ingredients;
  final String notes;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.pieceWeight,
    required this.ingredients,
    this.notes = '',
  });

  Recipe copyWith({
    String? id,
    String? name,
    String? category,
    double? pieceWeight,
    List<RecipeIngredient>? ingredients,
    String? notes,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      pieceWeight: pieceWeight ?? this.pieceWeight,
      ingredients: ingredients ?? this.ingredients,
      notes: notes ?? this.notes,
    );
  }
}

class RecipeIngredient {
  final String name;
  final double quantity;
  final String unit;

  const RecipeIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });
}
