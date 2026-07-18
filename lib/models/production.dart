import 'package:hive/hive.dart';

part 'production.g.dart';

@HiveType(typeId: 6)
class Production extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String recipeId;

  @HiveField(3)
  final String recipeName;

  @HiveField(4)
  final int lots;

  @HiveField(5)
  final double totalMassKg;

  @HiveField(6)
  final double pieceWeightGrams;

  @HiveField(7)
  final int totalPieces;

  @HiveField(8)
  final String notes;

  Production({
    required this.id,
    required this.date,
    required this.recipeId,
    required this.recipeName,
    required this.lots,
    required this.totalMassKg,
    required this.pieceWeightGrams,
    required this.totalPieces,
    this.notes = '',
  });
}
