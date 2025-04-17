import '../../domain/entities/result.dart';

class ResultModel extends Result {
  ResultModel({
    required super.subject,
    required super.icon,
    required super.score,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      subject: json['subject'],
      icon: json['icon'],
      score: json['score'],
    );
  }
}
