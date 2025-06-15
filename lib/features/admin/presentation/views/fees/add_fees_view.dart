import 'package:MySchool/core/constants/constants.dart';
import 'package:MySchool/core/utils/search_utlis.dart';
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

class AddFeesView extends StatefulWidget {
  const AddFeesView({super.key});
  static const String id = "/AddFeesView";

  @override
  State<AddFeesView> createState() => _AddFeesViewState();
}

class _AddFeesViewState extends State<AddFeesView> {
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController dueTimeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String? selectedStudent;
  bool showForm = false;
  bool isEdit = false;
  String? editingId;
  List<FeesEntity> filteredFees = [];

  final List<DropdownMenuItem<String>> studentItems = [
    DropdownMenuItem(value: "Student 1", child: Text("Student 1")),
    DropdownMenuItem(value: "Student 2", child: Text("Student 2")),
  ];
      void _addTextListeners() {
  final controllers = [
    totalAmountController,
    paidAmountController,
    dueTimeController,
    searchController,
  ];

  for (var controller in controllers) {
    controller.addListener(() => setState(() {}));
  }
}

  void openForm({FeesEntity? entity}) {
  setState(() {
    showForm = true;
    isEdit = entity != null;
    editingId = entity?.id;

    if (entity != null) {
      selectedStudent = entity.selectSudent;
      totalAmountController.text = entity.totalAmount.toString();
      paidAmountController.text = entity.paidAmount.toString();
      dueTimeController.text =
          TimeOfDay.fromDateTime(entity.dueDate).format(context); // ✅
    } else {
      selectedStudent = null;
      totalAmountController.clear();
      paidAmountController.clear();
      dueTimeController.clear();
    }
  });
}


  void resetForm() {
    setState(() {
      showForm = false;
      isEdit = false;
      editingId = null;
      totalAmountController.clear();
      paidAmountController.clear();
      searchController.clear();
      dueTimeController.clear();
      selectedStudent = null;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AddFeesCubit>().loadFees();
    _addTextListeners();
    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredFees =
            context
                .read<AddFeesCubit>()
                .state
                .fees
                .where((fee) => fee.selectSudent.toLowerCase().contains(query))
                .toList();
      });
    });
  }

  @override
  void dispose() {
    totalAmountController.dispose();
    paidAmountController.dispose();
    dueTimeController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Fees"),
      body:
          showForm
              ? CreateNewWidget(
                title: isEdit ? "Edit Fees" : "Add Fees",
                items: [
                  ClassDropdownWidget(
                    title: "select student",
                    items: studentItems,
                    selectedValue: selectedStudent,
                    onChanged:
                        (value) => setState(() => selectedStudent = value),
                  ),
                  CustomField(
                    controller: totalAmountController,
                    label: "Total Amount",
  keyboardType: TextInputType.numberWithOptions(decimal: true),

                  ),
                  CustomField(
                    controller: paidAmountController,
                    label: "Paid Amount",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),

                  ),
                  CustomField(
                    controller: dueTimeController, label: "Due Time"
                    , keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context);
      dueTimeController.text = formattedTime;
    }
  },
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
                        id: isEdit ? editingId! : const Uuid().v4(),
                        paidAmount: double.parse(paidAmountController.text),
                        totalAmount: double.parse(totalAmountController.text),
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
                  final feesList =
                      searchController.text.isEmpty ? state.fees : filteredFees;
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
                          title: "Add Fees",
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
                            final item = feesList[index]; 

                            return NewWidget(
                              title: SearchUtils.getHighlightedText(
                                item.selectSudent,
                                searchController.text,
                              ),
                              subtitle: item.totalAmount.toString(),
                              onEdit: () => openForm(entity: item),
                              onDelete:
                                  () => confirmDelete(
                                    context,
                                    title: "Delete",
                                    message:
                                        "Are you sure you want to delete this Fees?",
                                    onConfirm: () {
                                      context.read<AddFeesCubit>().deleteFees(
                                        item.id,
                                      );
                                    },
                                  ),
                            );
                          }, childCount: feesList.length),
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
