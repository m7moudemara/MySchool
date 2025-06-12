import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/domain/entities/fees_entity.dart';
import 'package:MySchool/features/admin/presentation/cubits/fees_cubits/fees_cubit.dart';
import 'package:MySchool/features/admin/presentation/widgets/class_dropdown_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_button.dart';
import 'package:MySchool/features/admin/presentation/widgets/custom_text_feild.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/add_widget.dart';
import '../../widgets/create_new_widget.dart';
import '../../widgets/new_widget.dart';

class FeesView extends StatefulWidget {
  const FeesView({super.key});
  static const String id = "/FeesView";

  @override
  State<FeesView> createState() => _FeesViewState();
}

class _FeesViewState extends State<FeesView> {
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController dueTimeController = TextEditingController();

  String? selectedStudent;
  bool showForm = false;
  bool isEdit = false;
  String? editingId;

  final List<DropdownMenuItem<String>> studentItems = [
    DropdownMenuItem(value: "Student 1", child: Text("Student 1")),
    DropdownMenuItem(value: "Student 2", child: Text("Student 2")),
  ];

  void openForm({FeesEntity? entity}) {
    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;
      selectedStudent = entity?.selectSudent;
    });
  }

  void resetForm() {
    setState(() {
      showForm = false;
      isEdit = false;
      editingId = null;
      dueTimeController.clear();
      selectedStudent = null;
    });
  }

  @override
  void initState() {
    super.initState();


    totalAmountController.addListener(() {
      setState(() {});
    });
    paidAmountController.addListener(() {
      setState(() {});
    });
    dueTimeController.addListener(() {
      setState(() {});
    });
    context.read<AddFeesCubit>().loadFees();
  }

  @override
  void dispose() {
    totalAmountController.dispose();
    paidAmountController.dispose();
    dueTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Classes"),
      body:
          showForm
              ? CreateNewWidget(
                title: isEdit ? "Edit Class" : "Add Class",
                items: [
                 
                  ClassDropdownWidget(
                    title: "select student",
                    items: studentItems,
                    selectedValue: selectedStudent,
                    onChanged:
                        (value) => setState(() => selectedStudent = value),
                  ),
                   CustomField(
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Total amount is required"
                                : null,
                    controller: totalAmountController,
                    label: "Total Amount",
                  ),
                   CustomField(
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Total amount is required"
                                : null,
                    controller: paidAmountController,
                    label: "Paid Amount",
                  ),
                   CustomField(
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Total amount is required"
                                : null,
                    controller: dueTimeController,
                    label: "Due Time",
                  ),
                  CreateButton(
                    label: isEdit ? "Update " : "Create ",
                    icon: isEdit ? Icons.restart_alt : Icons.add,
                    enabled:
                        totalAmountController.text.isNotEmpty &&
                    paidAmountController.text.isNotEmpty &&
                    dueTimeController.text.isNotEmpty &&
                        selectedStudent != null,

                    onPressed: () {
                      final entity = FeesEntity(
                        paidAmount:
                            double.tryParse(paidAmountController.text) ?? 0,
                        id: isEdit ? editingId! : const Uuid().v4(),
                        totalAmount:
                            double.tryParse(totalAmountController.text) ?? 0,
                        dueDate: DateTime.now(),
                        selectSudent: selectedStudent ?? '',
                      );

                      if (isEdit) {
                        context.read<AddFeesCubit>().updateFees(entity);
                      } else {
                        context.read<AddFeesCubit>().addFees(entity);
                      }
                      resetForm();
                    },
                  ),
                ],
              )
              : BlocBuilder<AddFeesCubit, AddFeesState>(
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: AddWidget(
                          onTap: () => openForm(),
                          title: "Add Classes",
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
                            final item = state.fees[index];
                            return NewWidget(
                              title: item.selectSudent,
                              subtitle: item.totalAmount.toString(),
                              onEdit: () => openForm(entity: item),
                              onDelete:
                                  () => confirmDelete(
                                    context,
                                    title: "Delete",
                                    message:
                                        "Are you sure you want to delete this Teacher?",
                                    onConfirm: () {
                                      context.read<AddFeesCubit>().deleteFees(
                                        item.id,
                                      );
                                    },
                                  ),
                            );
                          }, childCount: state.fees.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    ResponsiveUtils.getGridColumnCount(context),
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
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
