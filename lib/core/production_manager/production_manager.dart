// =======================================================
// CONTROLPAN
// Archivo: production_manager.dart
// Descripción:
// Coordina todos los motores de producción.
// =======================================================

import '../production_engine/ingredient.dart';
import '../production_engine/production_engine.dart';
import '../production_engine/production_result.dart';
import '../production_engine/bakers_percentage.dart';
import '../production_engine/hydration_engine.dart';
import '../production_engine/yield_engine.dart';

class ProductionManager {
  final ProductionEngine _productionEngine = ProductionEngine();
  final BakersPercentageEngine _bakersEngine =
      BakersPercentageEngine();
  final HydrationEngine _hydrationEngine =
      HydrationEngine();
  final YieldEngine _yieldEngine =
      YieldEngine();

  ProductionResult calculateProduction({
    required List<Ingredient> ingredients,
    required double pieceWeight,
  }) {
    return _productionEngine.calculate(
      ingredients: ingredients,
      pieceWeight: pieceWeight,
    );
  }

  Map<String, double> calculatePercentages(
      List<Ingredient> ingredients) {
    return _bakersEngine.calculate(ingredients);
  }

  double calculateHydration(
      List<Ingredient> ingredients) {
    return _hydrationEngine.calculate(ingredients);
  }

  double calculateYield({
    required double totalMass,
    double bakingLoss = 10,
  }) {
    return _yieldEngine.calculate(
      totalMass: totalMass,
      bakingLoss: bakingLoss,
    );
  }
}
