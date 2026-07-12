/// =======================================================
/// CONTROLPAN
/// Archivo: inventory_item.dart
/// Descripción:
/// Modelo del inventario.
/// Representa el estado actual de un ingrediente
/// dentro del almacén.
/// =======================================================

class InventoryItem {
  /// ID del ingrediente
  final String ingredientId;

  /// Nombre del ingrediente
  final String ingredientName;

  /// Categoría
  final String category;

  /// Unidad de medida
  final String unit;

  /// Existencia actual
  final double stock;

  /// Stock mínimo
  final double minimumStock;

  /// Precio de compra por unidad
  final double purchasePrice;

  /// Última actualización
  final DateTime lastUpdated;

  const InventoryItem({
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    required this.unit,
    required this.stock,
    required this.minimumStock,
    required this.purchasePrice,
    required this.lastUpdated,
  });

  InventoryItem copyWith({
    String? ingredientId,
    String? ingredientName,
    String? category,
    String? unit,
    double? stock,
    double? minimumStock,
    double? purchasePrice,
    DateTime? lastUpdated,
  }) {
    return InventoryItem(
      ingredientId: ingredientId ?? this.ingredientId,
      ingredientName: ingredientName ?? this.ingredientName,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      stock: stock ?? this.stock,
      minimumStock: minimumStock ?? this.minimumStock,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Indica si el ingrediente está por debajo del stock mínimo.
  bool get isLowStock => stock <= minimumStock;
}
