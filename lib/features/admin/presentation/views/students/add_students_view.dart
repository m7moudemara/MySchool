import 'dart:convert';

import 'package:MySchool/core/utils/search_utlis.dart';
import 'package:MySchool/core/utils/time.dart';
import 'package:MySchool/features/admin/domain/entities/student_entity.dart';
import 'package:MySchool/features/admin/presentation/cubits/student_cubits/student_cubit.dart';
import 'package:MySchool/features/admin/presentation/widgets/class_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/presentation/widgets/add_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_button.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_new_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/custom_text_feild.dart';
import 'package:MySchool/features/admin/presentation/widgets/new_widget.dart';

import '../../../../../constants/strings.dart';
import '../../../../../main.dart';

class AddStudentsView extends StatefulWidget {
  const AddStudentsView({super.key});
  static const String id = "/AddStudentsView";

  @override
  State<AddStudentsView> createState() => _AddStudentsViewState();
}

class _AddStudentsViewState extends State<AddStudentsView> {
  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController accountIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  // Fields
  String? gender;
  String? selectedClass;
  String? myParent;
  int? selectedClassId;
  int? selectedParentId;
  bool isActive = false;
  bool mustChangePassword = false;
  bool showForm = false;
  bool isEdit = false;
  String? editingId;
  List<StudentEntity> filteredStudents = [];

  final List<DropdownMenuItem<String>> genderItems = [
    DropdownMenuItem(value: "male", child: Text("male")),
    DropdownMenuItem(value: "female", child: Text("female")),
  ];
  final List<DropdownMenuItem<String>> classes = [
    // DropdownMenuItem(value: "class1", child: Text("Class 1")),
    // DropdownMenuItem(value: "class2", child: Text("Class 2")),
  ];
  final List<DropdownMenuItem<String>> parents = [
    // DropdownMenuItem(value: "parent1", child: Text("Parent 1")),
    // DropdownMenuItem(value: "parent2", child: Text("Parent 2")),
  ];

  void openForm({StudentEntity? entity}) {
    print(entity?.dateOfBirth);
    String? formatted;
    if (entity != null) {
      DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      DateTime date = inputFormat.parse(entity.dateOfBirth);
      formatted = DateFormat('dd/MM/yyyy').format(date);
    }

    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;
      fullNameController.text = entity?.fullName ?? '';
      accountIdController.text = entity?.accountId ?? '';
      passwordController.text = entity?.password ?? '';
      dobController.text = formatted ?? '';
      // dobController.text = entity?.dateOfBirth ?? '';
      nationalIdController.text = entity?.nationalId ?? '';
      phoneController.text = entity?.phoneNumber ?? '';
      addressController.text = entity?.address ?? '';
      selectedClass = entity?.selectedClass;
      myParent = entity?.myParent;
      gender = entity?.gender.toLowerCase();
      isActive = entity?.isActive ?? false;
      mustChangePassword = entity?.mustChangePassword ?? false;
    });
  }

  void resetForm() {
    setState(() {
      showForm = false;
      isEdit = false;
      editingId = null;
      fullNameController.clear();
      accountIdController.clear();
      passwordController.clear();
      dobController.clear();
      nationalIdController.clear();
      phoneController.clear();
      addressController.clear();
      searchController.clear();
      selectedClass = null;
      myParent = null;
      gender = null;
      isActive = false;
      mustChangePassword = false;
    });
  }

  getClasses() async {
    final url = Uri.parse('$baseUrl/api/classes');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      List classesx = jsonDecode(response.body)['data'];
      for (var item in classesx) {
        setState(() {
          classes.add(
            DropdownMenuItem(value: item['name'], child: Text(item['name'])),
          );
        });
      }
    } else {
      throw Exception('error');
    }
  }

  getParents() async {
    final url = Uri.parse(
      '$baseUrl/api/accounts?Pagesize=500&Where%5Brole%5D=Guardian',
    );
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      for (var item in result) {
        setState(() {
          parents.add(
            DropdownMenuItem(value: item['name'], child: Text(item['name'])),
          );
        });
      }
    } else {
      throw Exception('error');
    }
  }

  @override
  void initState() {
    getClasses();
    getParents();
    super.initState();
    context.read<AddStudentCubit>().loadStudents();
    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredStudents =
            context
                .read<AddStudentCubit>()
                .state
                .students
                .where(
                  (student) => student.fullName.toLowerCase().contains(query),
                )
                .toList();
      });
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    accountIdController.dispose();
    passwordController.dispose();
    dobController.dispose();
    nationalIdController.dispose();
    phoneController.dispose();
    addressController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Students"),
      body:
          showForm
              ? SingleChildScrollView(
                child: CreateNewWidget(
                  title: isEdit ? "Edit Student" : "Add Student",
                  items: [
                    CustomField(
                      controller: fullNameController,
                      label: "Full Name",
                    ),
                    CustomField(
                      controller: accountIdController,
                      label: "Account ID",
                    ),
                    CustomField(
                      controller: passwordController,
                      label: "Password",
                      obscureText: true,
                    ),
                    ClassDropdownWidget(
                      title: "Gender",
                      items: genderItems,
                      selectedValue: gender,
                      onChanged:
                          (value) => setState(() => gender = value ?? ''),
                    ),
                    CustomField(
                      controller: dobController,
                      label: "Date of Birth",
                      readOnly: true,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );

                        if (selectedDate != null) {
                          dobController.text = formatDate(selectedDate);
                          setState(() {});
                        }
                      },
                    ),
                    CustomField(
                      controller: nationalIdController,
                      label: "National ID",
                      keyboardType: TextInputType.number,
                    ),
                    CustomField(
                      controller: phoneController,
                      label: "Phone Number",
                      keyboardType: TextInputType.phone,
                    ),
                    CustomField(
                      controller: addressController,
                      label: "Home Address",
                    ),
                    ClassDropdownWidget(
                      title: "Select Class",
                      items: classes,
                      selectedValue: selectedClass,
                      onChanged: (value) {
                        print('*********');
                        print(value);
                        setState(() => selectedClass = value ?? '');
                        print(selectedClass);
                      },
                    ),
                    ClassDropdownWidget(
                      title: "Select Parent",
                      items: parents,
                      selectedValue: myParent,
                      onChanged:
                          (value) => setState(() => myParent = value ?? ''),
                    ),
                    CheckboxListTile(
                      value: isActive,
                      onChanged: (val) => setState(() => isActive = val!),
                      title: const Text("Active Account"),
                    ),
                    CheckboxListTile(
                      value: mustChangePassword,
                      onChanged:
                          (val) => setState(() => mustChangePassword = val!),
                      title: const Text("Must Change Password"),
                    ),
                    const SizedBox(height: 12),
                    CreateButton(
                      label: isEdit ? "Update" : "Create",
                      icon: isEdit ? Icons.edit : Icons.add,
                      enabled:
                          fullNameController.text.isNotEmpty &&
                          accountIdController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          dobController.text.isNotEmpty &&
                          nationalIdController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          (isActive || mustChangePassword),
                      onPressed: () {
                        final entity = StudentEntity(
                          id: isEdit ? editingId! : const Uuid().v4(),
                          fullName: fullNameController.text,
                          accountId: accountIdController.text,
                          password: passwordController.text,
                          gender: gender ?? '',
                          dateOfBirth: dobController.text,
                          nationalId: nationalIdController.text,
                          phoneNumber: phoneController.text,
                          address: addressController.text,
                          selectedClass: selectedClass ?? '',
                          myParent: myParent ?? '',
                          isActive: isActive,
                          mustChangePassword: mustChangePassword,
                        );

                        if (isEdit) {
                          context.read<AddStudentCubit>().updateStudent(entity);
                        } else {
                          context.read<AddStudentCubit>().addStudent(entity);
                        }

                        resetForm();
                      },
                    ),
                  ],
                ),
              )
              : BlocBuilder<AddStudentCubit, AddStudentState>(
                builder: (context, state) {
                  final studentsList =
                      searchController.text.isEmpty
                          ? state.students
                          : filteredStudents;

                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: AddWidget(
                          onTap: () => openForm(),
                          title: "Add Student",
                          width: ResponsiveUtils.getResponsiveWidth(
                            context,
                            0.5,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final item = studentsList[index];
                            return NewWidget(
                              title: SearchUtils.getHighlightedText(
                                item.fullName,
                                searchController.text,
                              ),
                              subtitle: "",
                              onEdit: () => openForm(entity: item),
                              onDelete:
                                  () => confirmDelete(
                                    context,
                                    title: "Delete",
                                    message:
                                        "Are you sure you want to delete this student?",
                                    onConfirm: () {
                                      context
                                          .read<AddStudentCubit>()
                                          .deleteStudent(item.id);
                                      final query =
                                          searchController.text.toLowerCase();
                                      setState(() {
                                        filteredStudents =
                                            context
                                                .read<AddStudentCubit>()
                                                .state
                                                .students
                                                .where(
                                                  (student) => student.fullName
                                                      .toLowerCase()
                                                      .contains(query),
                                                )
                                                .toList();
                                      });
                                    },
                                  ),
                            );
                          }, childCount: studentsList.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    ResponsiveUtils.getGridColumnCount(context),
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio:
                                    ResponsiveUtils.getResponsiveAspectRatio(
                                      context,
                                    ),
                              ),
                        ),
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
