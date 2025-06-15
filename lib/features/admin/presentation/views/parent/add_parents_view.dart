import 'package:MySchool/core/utils/search_utlis.dart';
import 'package:MySchool/core/utils/time.dart' as Utils;
import 'package:MySchool/features/admin/domain/entities/parent_entity.dart';
import 'package:MySchool/features/admin/presentation/cubits/parent_cubits/add_parent_cubit.dart';
import 'package:MySchool/features/admin/presentation/widgets/class_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:MySchool/core/constants/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/presentation/widgets/add_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_button.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_new_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/custom_text_feild.dart';
import 'package:MySchool/features/admin/presentation/widgets/new_widget.dart';

class AddParentsView extends StatefulWidget {
  const AddParentsView({super.key});
  static const String id = "/AddParentsView";

  @override
  State<AddParentsView> createState() => _AddParentsViewState();
}

class _AddParentsViewState extends State<AddParentsView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController accountIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String? gender;
  bool isActive = false;
  bool mustChangePassword = false;
  bool showForm = false;
  bool isEdit = false;
  String? editingId;
  List<ParentEntity> filteredParents = [];

  final List<DropdownMenuItem<String>> genderItems = [
    DropdownMenuItem(value: "male", child: Text("male")),
    DropdownMenuItem(value: "female", child: Text("female")),
  ];

  void _addTextListeners() {
    final controllers = [
      fullNameController,
      accountIdController,
      passwordController,
      dobController,
      nationalIdController,
      phoneController,
      addressController,
    ];

    for (var controller in controllers) {
      controller.addListener(() => setState(() {}));
    }
  }

  void openForm({ParentEntity? entity}) {
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
      gender = entity?.gender;
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
      gender = null;
      searchController.clear();
      isActive = false;
      mustChangePassword = false;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AddParentCubit>().loadParents();
    _addTextListeners();
    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredParents =
            context
                .read<AddParentCubit>()
                .state
                .parents
                .where(
                  (parent) => parent.fullName.toLowerCase().contains(query),
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
      appBar: CustomAppBar(title: "Parents"),
      body:
          showForm
              ? SingleChildScrollView(
                child: CreateNewWidget(
                  title: isEdit ? "Edit Parent" : "Add Parent",
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

                      // isPassword: true,
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
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          dobController.text = Utils.formatDate(date);
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
                      icon: isEdit ? Icons.restart_alt : Icons.add,
                      enabled:
                          fullNameController.text.isNotEmpty &&
                          accountIdController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          dobController.text.isNotEmpty &&
                          gender != null &&
                          nationalIdController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          (isActive || mustChangePassword),
                      onPressed: () {
                        final entity = ParentEntity(
                          id: isEdit ? editingId! : const Uuid().v4(),
                          fullName: fullNameController.text,
                          accountId: accountIdController.text,
                          password: passwordController.text,
                          gender: gender ?? '',
                          dateOfBirth: dobController.text,
                          nationalId: nationalIdController.text,
                          phoneNumber: phoneController.text,
                          address: addressController.text,
                          isActive: isActive,
                          mustChangePassword: mustChangePassword,
                        );

                        if (isEdit) {
                          context.read<AddParentCubit>().updateParent(entity);
                        } else {
                          context.read<AddParentCubit>().addParent(entity);
                        }

                        resetForm();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              )
              : BlocBuilder<AddParentCubit, AddParentState>(
                builder: (context, state) {
                  final parentsList =
                      searchController.text.isEmpty
                          ? state.parents
                          : filteredParents;
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
                          title: "Add Parent",
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
                            final item = parentsList[index];
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
                                        "Are you sure you want to delete this parent?",
                                    onConfirm: () {
                                      context
                                          .read<AddParentCubit>()
                                          .deleteParent(item.id);
                                      final query =
                                          searchController.text.toLowerCase();
                                      setState(() {
                                        filteredParents =
                                            context
                                                .read<AddParentCubit>()
                                                .state
                                                .parents
                                                .where(
                                                  (parent) => parent.fullName
                                                      .toLowerCase()
                                                      .contains(query),
                                                )
                                                .toList();
                                      });
                                    },
                                  ),
                            );
                          }, childCount: parentsList.length),
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
