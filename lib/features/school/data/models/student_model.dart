




import 'package:MySchool/features/school/domain/entities/user_type.dart';

class Student extends IUser {
  @override final String id;
  @override final String name;
  @override final String imageUrl;

  final String className;
  final String parentId;

  @override String get displayInfo => className;
  @override final int? totalDays;
  @override final int? absentDays;
  @override bool get showAttendance => true;
  @override UserType get type => UserType.student;

  Student({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.className,
    required this.totalDays,
    required this.absentDays,
    required this.parentId,
  }); 

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      className: json['className'] ?? '',
      totalDays: json['totalDays'] ?? 0,
      absentDays: json['absentDays'] ?? 0,
      parentId: json['parentId'] ?? '',
    );
  }
}
