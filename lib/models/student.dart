enum UserType { student, teacher, parent }

abstract class IUser {
  String get id;
  String get name;
  String get imageUrl;
  String get displayInfo; // سيحل محل student.className
  int? get totalDays;    // جعله اختياريًا
  int? get absentDays;   // جعله اختياريًا
  bool get showAttendance; // تحديد إذا كان سيظهر مؤشر الحضور
}
class Student implements IUser {
  @override final String id;
  @override final String name;
  @override final String imageUrl;
  @override final String className;
  
  @override 
  String get displayInfo => className;
  
  @override final int totalDays;
  @override final int absentDays;
  
  @override 
  bool get showAttendance => true;

  Student({required this.id, required this.name, required this.imageUrl, 
          required this.className, required this.totalDays, required this.absentDays});
}

class Teacher implements IUser {
  @override final String id;
  @override final String name;
  @override final String imageUrl;
  @override final String department;
  
  @override 
  String get displayInfo => department;
  
  @override final int? totalDays = null;
  @override final int? absentDays = null;
  
  @override 
  bool get showAttendance => false; 

  Teacher({required this.id, required this.name, required this.imageUrl, 
          required this.department});
}

class Parent implements IUser {
  @override final String id;
  @override final String name;
  @override final String imageUrl;
  @override final String childrenInfo;
  
  @override 
  String get displayInfo => childrenInfo;
  
  @override final int? totalDays = null;
  @override final int? absentDays = null;
  
  @override 
  bool get showAttendance => false; 

  Parent({required this.id, required this.name, required this.imageUrl, 
         required this.childrenInfo});
}