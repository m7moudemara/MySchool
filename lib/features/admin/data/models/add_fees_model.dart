import 'package:MySchool/features/admin/domain/entities/fees_entity.dart';


class AddFeesModel extends FeesEntity {
  AddFeesModel({
    required super.id,
    required super.dueDate, required super.selectSudent, required super.totalAmount, required super.paidAmount,
  });

  factory AddFeesModel.fromJson(Map<String, dynamic> json) {
    return AddFeesModel(
      id: json['id'],
      dueDate: json['dueDate'],
      selectSudent: json['selectSudent'],
      totalAmount: json['totalAmount'],
      paidAmount: json['paidAmount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'dueDate': dueDate,
    'selectSudent': selectSudent,
    'totalAmount': totalAmount,
    'paidAmount': paidAmount,
  };
}
