import 'dart:convert';

import 'package:MySchool/core/constants/constants.dart';
import 'package:MySchool/core/constants/strings.dart';

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
import 'package:http/http.dart' as http;
import '../../../../../main.dart';
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

  String? selectedStudentName;
  int? selectedStudentId;
  bool showForm = false;
  bool isEdit = false;
  String? editingId;
  List<FeesEntity> filteredFees = [];

  // final List<DropdownMenuItem<String>> studentItems = [
  //   DropdownMenuItem(value: "Student 1", child: Text("Student 1")),
  //   DropdownMenuItem(value: "Student 2", child: Text("Student 2")),
  // ];

  final List<DropdownMenuItem<int>> studentItemsx = [
    // DropdownMenuItem(value: 1, child: Text("Student 1")),
    // DropdownMenuItem(value: 2, child: Text("Student 2")),
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

  getStudents() async {
    final url = Uri.parse(
      '$baseUrl/api/accounts?Pagesize=500&Where%5Brole%5D=Student',
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
      for (var element in result) {
        setState(() {
          studentItemsx.add(
            DropdownMenuItem(
              value: element['id'],
              child: Text(element['name']),
            ),
          );
        });
      }

      return result;
    } else {
      throw Exception('error');
    }
  }

  void openForm({FeesEntity? entity}) {
    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;

      if (entity != null) {
        selectedStudentId = entity.selectSudentId;
        totalAmountController.text = entity.totalAmount.toString();
        paidAmountController.text = entity.paidAmount.toString();
        dueTimeController.text = TimeOfDay.fromDateTime(
          entity.dueDate,
        ).format(context);
      } else {
        selectedStudentId = null;
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
      selectedStudentId = null;
    });
  }

  @override
  void initState() {
    super.initState();
    getStudents();
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
                .where(
                  (fee) => fee.selectSudentName.toLowerCase().contains(query),
                )
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
                  ClassDropdownWidget2(
                    title: "select student",
                    items: studentItemsx,
                    selectedValue: selectedStudentId,
                    onChanged:
                        (value) => setState(() => selectedStudentId = value),
                  ),
                  CustomField(
                    controller: totalAmountController,
                    label: "Total Amount",
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  CustomField(
                    controller: paidAmountController,
                    label: "Paid Amount",
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  CustomField(
                    controller: dueTimeController,
                    label: "Due Time",
                    keyboardType: TextInputType.datetime,
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
                        selectedStudentId != null,

                    onPressed: () {
                      final entity = FeesEntity(
                        id: isEdit ? editingId! : const Uuid().v4(),
                        paidAmount: double.parse(paidAmountController.text),
                        totalAmount: double.parse(totalAmountController.text),
                        dueDate: DateTime.now(),
                        selectSudentId: selectedStudentId ?? 0,
                        selectSudentName: selectedStudentName ?? '',
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
                                item.selectSudentName,
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
