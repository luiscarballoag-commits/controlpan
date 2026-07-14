class CostItem {
  final String name;
  final String category;
  final double amount;
  final double unitPrice;

  const CostItem({
    required this.name,
    required this.category,
    required this.amount,
    required this.unitPrice,
  });

  double get total => amount * unitPrice;

  CostItem copyWith({
    String? name,
    String? category,
    double? amount,
    double? unitPrice,
  }) {
    return CostItem(
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}
