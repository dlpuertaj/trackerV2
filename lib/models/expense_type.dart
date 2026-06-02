class ExpenseType {
  final String name;
  final bool isFixed;
  final double? fixedAmount;

  ExpenseType({
    required this.name,
    required this.isFixed,
    this.fixedAmount,
  });
}
