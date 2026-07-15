import 'package:hive/hive.dart';

import '../models/inventory_movement.dart';

class InventoryMovementService {
  static const String boxName =
      'inventory_movements';

  Box<InventoryMovement> get _box =>
      Hive.box<InventoryMovement>(boxName);

  List<InventoryMovement>
      getAllMovements() {
    return _box.values.toList().reversed.toList();
  }

  void addMovement(
      InventoryMovement movement) {
    _box.add(movement);
  }

  InventoryMovement? getMovement(
      int index) {
    if (index < 0 ||
        index >= _box.length) {
      return null;
    }

    return _box.getAt(index);
  }

  int count() {
    return _box.length;
  }

  bool get isEmpty => _box.isEmpty;

  bool get isNotEmpty =>
      _box.isNotEmpty;  List<InventoryMovement>
      getEntries() {

    return _box.values
        .where(
          (movement) =>
              movement.type ==
              "Entrada",
        )
        .toList()
        .reversed
        .toList();
  }

  List<InventoryMovement>
      getExits() {

    return _box.values
        .where(
          (movement) =>
              movement.type ==
              "Salida",
        )
        .toList()
        .reversed
        .toList();
  }

  int get totalEntries =>
      getEntries().length;

  int get totalExits =>
      getExits().length;

  int get totalMovements =>
      _box.length;

  List<InventoryMovement>
      getLatestMovements({
    int limit = 10,
  }) {

    final list =
        getAllMovements();

    if (list.length <= limit) {
      return list;
    }

    return list.take(limit).toList();
  }  void deleteMovement(
    int index,
  ) {
    if (index >= 0 &&
        index < _box.length) {
      _box.deleteAt(index);
    }
  }

  void clear() {
    _box.clear();
  }
}
