import '../../models/ingredient_catalog.dart';
import '../../models/inventory_movement.dart';
import '../../services/ingredient_service.dart';
import '../../services/inventory_movement_service.dart';

class InventoryManager {
  final IngredientService _ingredientService = IngredientService();
  final InventoryMovementService _movementService =
      InventoryMovementService();

  /// Compra o entrada de inventario.
  Future<void> purchaseIngredient({
    required int index,
    required IngredientCatalog ingredient,
    required double quantity,
    required double purchasePrice,
    required String reference,
    String notes = '',
  }) async {
    final updated = IngredientCatalog(
      id: ingredient.id,
      name: ingredient.name,
      category: ingredient.category,
      unit: ingredient.unit,
      purchasePrice: purchasePrice,
      stock: ingredient.stock + quantity,
      minimumStock: ingredient.minimumStock,
      notes: ingredient.notes,
    );

    _ingredientService.updateIngredient(index, updated);

    _movementService.addMovement(
      InventoryMovement(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        ingredientId: updated.id,
        ingredientName: updated.name,
        quantity: quantity,
        unit: updated.unit,
        type: 'Entrada',
        reference: reference,
        notes: notes,
      ),
    );
  }

  /// Consumo o salida de inventario.
  Future<void> consumeIngredient({
    required int index,
    required IngredientCatalog ingredient,
    required double quantity,
    required String reason,
    String notes = '',
  }) async {
    if (quantity > ingredient.stock) {
      throw Exception('Stock insuficiente.');
    }

    final updated = IngredientCatalog(
      id: ingredient.id,
      name: ingredient.name,
      category: ingredient.category,
      unit: ingredient.unit,
      purchasePrice: ingredient.purchasePrice,
      stock: ingredient.stock - quantity,
      minimumStock: ingredient.minimumStock,
      notes: ingredient.notes,
    );

    _ingredientService.updateIngredient(index, updated);

    _movementService.addMovement(
      InventoryMovement(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        ingredientId: updated.id,
        ingredientName: updated.name,
        quantity: quantity,
        unit: updated.unit,
        type: 'Salida',
        reference: reason,
        notes: notes,
      ),
    );
  }

  double getCurrentStock(IngredientCatalog ingredient) {
    return ingredient.stock;
  }

  double getInventoryValue(List<IngredientCatalog> ingredients) {
    double total = 0;

    for (final ingredient in ingredients) {
      total += ingredient.stock * ingredient.purchasePrice;
    }

    return total;
  }
}
