import 'package:hive/hive.dart';

import '../models/ingredient_catalog.dart';

class InventoryService {
  final Box<IngredientCatalog> _box =
      Hive.box<IngredientCatalog>('ingredients');

  List<IngredientCatalog> getAllItems() {
    return _box.values.toList();
  }

  double getInventoryValue() {
    double total = 0;

    for (final item in _box.values) {
      total += item.stock * item.purchasePrice;
    }

    return total;
  }

  int getTotalIngredients() {
    return _box.length;
  }

  List<IngredientCatalog> getLowStockItems() {
    return _box.values
        .where((item) => item.stock <= item.minimumStock)
        .toList();
  }
}
