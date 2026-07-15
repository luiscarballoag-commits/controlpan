import 'package:hive/hive.dart';

part 'inventory_movement.g.dart';

@HiveType(typeId: 3)
class InventoryMovement extends HiveObject {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String ingredient;

  @HiveField(4)
  final double quantity;

  @HiveField(5)
  final String unit;

  @HiveField(6)
  final String reason;

  @HiveField(7)
  final String notes;

  InventoryMovement({
    required this.id,
    required this.date,
    required this.type,
    required this.ingredient,
    required this.quantity,
    required this.unit,
    required this.reason,
    required this.notes,
  });
}
