import 'package:MySchool/features/admin/presentation/cubits/teacher_cubits/add_teacher_cubit.dart';
import 'package:MySchool/features/admin/presentation/widgets/class_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/domain/entities/teacher_entity.dart';
import 'package:MySchool/features/admin/presentation/widgets/add_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_button.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_new_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/custom_text_feild.dart';
import 'package:MySchool/features/admin/presentation/widgets/new_widget.dart';

class AddTeachersView extends StatefulWidget {
  const AddTeachersView({super.key});
  static const String id = "/TeacherView";

  @override
  State<AddTeachersView> createState() => _AddTeachersViewState();
}

class _AddTeachersViewState extends State<AddTeachersView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController accountIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? gender = "male";
  bool isActive = false;
  bool mustChangePassword = false;

  bool showForm = false;
  bool isEdit = false;
  String? editingId;
  final List<DropdownMenuItem<String>> genderItems = [
    DropdownMenuItem(value: "male", child: Text("male")),
    DropdownMenuItem(value: "female", child: Text("female")),
  ];

  void openForm({TeacherEntity? entity}) {
    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;
      fullNameController.text = entity?.fullName ?? '';
      accountIdController.text = entity?.accountId ?? '';
      passwordController.text = entity?.password ?? '';
      dobController.text = entity?.dateOfBirth ?? '';
      nationalIdController.text = entity?.nationalId ?? '';
      phoneController.text = entity?.phoneNumber ?? '';
      addressController.text = entity?.address ?? '';
      gender = entity?.gender ?? 'male';
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
      gender = 'Male';
      isActive = false;
      mustChangePassword = false;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AddTeacherCubit>().loadTeachers();
    fullNameController.addListener(() {
      setState(() {});
    });
    accountIdController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    dobController.addListener(() {
      setState(() {});
    });
    nationalIdController.addListener(() {
      setState(() {});
    });
    phoneController.addListener(() {
      setState(() {});
    });
    addressController.addListener(() {
      setState(() {});
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Teachers"),
      body:
          showForm
              ? SingleChildScrollView(
                child: CreateNewWidget(
                  title: isEdit ? "Edit Teacher" : "Add Teacher",
                  items: [
                    CustomField(
                      controller: fullNameController,
                      label: "Full Name",
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Required"
                                  : null,
                    ),
                    CustomField(
                      controller: accountIdController,
                      label: "Account ID",
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Required"
                                  : null,
                    ),
                    CustomField(
                      controller: passwordController,
                      label: "Password",
                      // isPassword: true,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Required"
                                  : null,
                    ),
                    ClassDropdownWidget(
                      title: "Gender",
                      items: genderItems,
                      selectedValue: gender,
                      onChanged:
                          (value) => setState(() => gender = value ?? 'male'),
                    ),
                    CustomField(
                      controller: dobController,
                      label: "Date of Birth",
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Required"
                                  : null,
                    ),
                    CustomField(
                      controller: nationalIdController,
                      label: "National ID",
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Required"
                                  : null,
                    ),
                    CustomField(
                      controller: phoneController,
                      label: "Phone Number",
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Required"
                                  : null,
                    ),
                    CustomField(
                      controller: addressController,
                      label: "Home Address",
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Required"
                                  : null,
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
                          addressController.text.isNotEmpty,
                      onPressed: () {
                        final entity = TeacherEntity(
                          id: isEdit ? editingId! : const Uuid().v4(),
                          fullName: fullNameController.text,
                          accountId: accountIdController.text,
                          password: passwordController.text,
                          gender: gender ?? 'Male',
                          dateOfBirth: dobController.text,
                          nationalId: nationalIdController.text,
                          phoneNumber: phoneController.text,
                          address: addressController.text,
                          isActive: isActive,
                          mustChangePassword: mustChangePassword,
                        );

                        if (isEdit) {
                          context.read<AddTeacherCubit>().updateTeacher(entity);
                        } else {
                          context.read<AddTeacherCubit>().addTeacher(entity);
                        }

                        resetForm();
                        setState(() {});

                      },
                    ),
                  ],
                ),
              )
              : BlocBuilder<AddTeacherCubit, AddTeacherState>(
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: AddWidget(
                          onTap: () => openForm(),
                          title: "Add Teacher",
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
                            final item = state.teachers[index];
                            return NewWidget(
                              title: item.fullName,
                              subtitle: "",
                              onEdit: () => openForm(entity: item),
                              onDelete:
                                  () => confirmDelete(
                                    context,
                                    title: "Delete",
                                    message:
                                        "Are you sure you want to delete this teacher?",
                                    onConfirm: () {
                                      context
                                          .read<AddTeacherCubit>()
                                          .deleteTeacher(item.id);
                                    },
                                  ),
                            );
                          }, childCount: state.teachers.length),
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
