/// =======================================================
/// CONTROLPAN
/// Archivo: ingredient_catalog.dart
/// Descripción:
/// Modelo del catálogo de ingredientes.
/// Será utilizado por Recetas, Inventario,
/// Producción y Estructura de Costos.
/// =======================================================

class IngredientCatalog {
  final String id;

  /// Nombre del ingrediente
  final String name;

  /// Categoría
  final String category;

  /// Unidad de medida
  final String unit;

  /// Precio de compra
  final double purchasePrice;

  /// Cantidad disponible en inventario
  final double stock;

  /// Stock mínimo recomendado
  final double minimumStock;

  /// Observaciones
  final String notes;

  const IngredientCatalog({
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
