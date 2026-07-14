import 'package:hive/hive.dart';

import '../models/ingredient_catalog.dart';

class IngredientService {
  static const String boxName = 'ingredients';

  Box get _box => Hive.box(boxName);

  List<IngredientCatalog> getAllIngredients() {
    return _box.values
        .cast<IngredientCatalog>()
        .toList();
  }

  void addIngredient(IngredientCatalog ingredient) {
    _box.add(ingredient);
  }

  void updateIngredient(
    int index,
    IngredientCatalog ingredient,
  ) {
    _box.putAt(index, ingredient);
  }

  void deleteIngredient(int index) {
    _box.deleteAt(index);
  }
}
