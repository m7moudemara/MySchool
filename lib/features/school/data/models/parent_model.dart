import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';

// This class represents a Parent model in a school management system.
class Parent extends IUser {
  @override
  final int id;
  // final String id;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final bool isFirstLogin;
  final String childrenInfo;
  final List<Student> children;
  // The information about the children of the parent.
  @override
  String get displayInfo => childrenInfo;
  @override
  int? get totalDays => null;
  @override
  int? get absentDays => null;

  @override
  UserType get type => UserType.parent;

  Parent( {
    required this.isFirstLogin,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.childrenInfo,
    required this.children,
  });

  // Factory constructor to create a Parent instance from JSON data.
  factory Parent.fromJson(Map<String, dynamic> json) {
    final childrenJson = json['children'];

    List<Student> childrenList = [];

    if (childrenJson != null && childrenJson is List) {
      childrenList = childrenJson.map((i) => Student.fromJson(i)).toList();
    }

    return Parent(
            isFirstLogin : json['isFirstLogin'] ?? true,

      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      childrenInfo: json['childrenInfo'] ?? '...\'s parent',
      children: childrenList,
    );
  }
}
