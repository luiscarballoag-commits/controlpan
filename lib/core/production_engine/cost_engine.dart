class CostEngine {
  double totalCost(Map<String, double> costs) {
    return costs.values.fold(0.0, (a, b) => a + b);
  }

  double costPerPiece({
    required double totalCost,
    required int pieces,
  }) {
    if (pieces == 0) return 0;
    return totalCost / pieces;
  }
}
