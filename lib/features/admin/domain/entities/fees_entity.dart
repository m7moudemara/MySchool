class FeesEntity {
  final String id;
  final String selectSudent;
  final double totalAmount;
  final double paidAmount;
  final DateTime dueDate;
  

  FeesEntity({
    required this.id,
    required this.selectSudent,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueDate,
  });
}