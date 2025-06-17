class FeesEntity {
  final String id;
  final int selectSudentId;
  final String selectSudentName;
  final double totalAmount;
  final double paidAmount;
  final DateTime dueDate;
  

  FeesEntity({
    required this.id,
    required this.selectSudentId,
    required this.selectSudentName,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueDate,
  });
}