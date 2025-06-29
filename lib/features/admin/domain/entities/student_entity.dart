class StudentEntity {
  final String id;
  final String fullName;
  final String accountId;
  final String password;
  final String gender;
  final String dateOfBirth;
  final String nationalId;
  final String phoneNumber;
  final String address;
  final String selectedClass;
  final String myParent;
  final bool isActive;
  final bool mustChangePassword;

  const StudentEntity({
    required this.id,
    required this.fullName,
    required this.accountId,
    required this.password,
    required this.gender,
    required this.dateOfBirth,
    required this.nationalId,
    required this.phoneNumber,
    required this.address,
    required this.selectedClass,
    required this.myParent,
    required this.isActive,
    required this.mustChangePassword,
  });

    factory StudentEntity.fromJson(Map<String, dynamic> json) {
    return StudentEntity(
      id: json['id'].toString(),
      fullName: json['name'],
      accountId: json['user_name'],
      password: json['password']??'',
      gender: json['gender']?? 'Male',
      dateOfBirth: json['date_of_birth']??'',
      nationalId: json['national_id']??'',
      phoneNumber: json['phone_number']??'',
      address: json['address']??'',
      isActive: json['is_active']?? true,
      mustChangePassword: json['must_change_password']?? true,
      selectedClass:json['selected_class']?? '',
      myParent: json['my_parent']??''
    );
  }

}
