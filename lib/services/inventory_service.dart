import '../models/inventory_item.dart';

class InventoryService {
  static final List<InventoryItem> _inventory = [];

  List<InventoryItem> getAllItems() {
    return List.unmodifiable(_inventory);
  }

  void addItem(InventoryItem item) {
    _inventory.add(item);
  }

  void updateItem(
    String ingredientId,
    InventoryItem updatedItem,
  ) {
    final index = _inventory.indexWhere(
      (item) => item.ingredientId == ingredientId,
    );

    if (index != -1) {
      _inventory[index] = updatedItem;
    }
  }

  void deleteItem(String ingredientId) {
    _inventory.removeWhere(
      (item) => item.ingredientId == ingredientId,
    );
  }

  InventoryItem? getItem(String ingredientId) {
    try {
      return _inventory.firstWhere(
        (item) => item.ingredientId == ingredientId,
      );
    } catch (_) {
      return null;
    }
  }

  void increaseStock(
    String ingredientId,
    double quantity,
  ) {
    final item = getItem(ingredientId);

    if (item == null) return;

    updateItem(
      ingredientId,
      item.copyWith(
        stock: item.stock + quantity,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  void decreaseStock(
    String ingredientId,
    double quantity,
  ) {
    final item = getItem(ingredientId);

    if (item == null) return;

    updateItem(
      ingredientId,
      item.copyWith(
        stock: item.stock - quantity,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  bool get isEmpty => _inventory.isEmpty;
}
