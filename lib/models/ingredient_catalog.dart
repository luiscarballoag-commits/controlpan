import 'package:hive/hive.dart';

part 'ingredient_catalog.g.dart';

@HiveType(typeId: 0)
class IngredientCatalog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String unit;

  @HiveField(4)
  final double purchasePrice;

  @HiveField(5)
  final double stock;

  @HiveField(6)
  final double minimumStock;

  @HiveField(7)
  final String notes;

  IngredientCatalog({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    this.purchasePrice = 0,
    this.stock = 0,
    this.minimumStock = 0,
    this.notes = '',
  });

  IngredientCatalog copyWith({
    String? id,
    String? name,
    String? category,
    String? unit,
    double? purchasePrice,
    double? stock,
    double? minimumStock,
    String? notes,
  }) {
    return IngredientCatalog(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      stock: stock ?? this.stock,
      minimumStock: minimumStock ?? this.minimumStock,
      notes: notes ?? this.notes,
    );
  }
}
