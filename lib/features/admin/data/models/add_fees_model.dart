import 'package:MySchool/features/admin/domain/entities/fees_entity.dart';

class AddFeesModel extends FeesEntity {
  AddFeesModel({
    required super.id,
    required super.dueDate,
    required super.selectSudentId,
    required super.selectSudentName,
    required super.totalAmount,
    required super.paidAmount,
  });

  factory AddFeesModel.fromJson(Map<String, dynamic> json) {
    DateTime xx = DateTime.parse(json['due_date']).toLocal();
    return AddFeesModel(
      id: json['id'].toString(),
      dueDate: xx,
      // selectSudent: json['selectSudent'],
      selectSudentId: json['student']['id'],
      selectSudentName: json['student']['name'],
      totalAmount: json['total_amount'],
      paidAmount: json['paid_amount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'dueDate': dueDate,
    'selectSudent': selectSudentId,
    'totalAmount': totalAmount,
    'paidAmount': paidAmount,
  };
}
