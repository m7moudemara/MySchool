import 'dart:convert';

import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/features/time_table/presentation/widgets/day_selector_widget.dart';
import 'package:MySchool/features/time_table/presentation/widgets/days_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:MySchool/core/constants/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/domain/entities/timetable_entity.dart';
import 'package:MySchool/features/admin/presentation/cubits/timetable_cubits/timetable_cubit.dart';
import 'package:MySchool/features/admin/presentation/widgets/add_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/class_dropdown_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_button.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_new_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/custom_text_feild.dart';
import 'package:MySchool/features/admin/presentation/widgets/new_widget.dart';
import 'package:http/http.dart' as http;

import '../../../../../main.dart';

class AddTimeTableView extends StatefulWidget {
  const AddTimeTableView({super.key});
  static const String id = "/AddTimeTableView";

  @override
  State<AddTimeTableView> createState() => _AddTimeTableViewState();
}

class _AddTimeTableViewState extends State<AddTimeTableView> {
  String? selectedClass;
  int? selectedClassId;
  String? selectedSubject;
  int? selectedSubjectId;
  String? selectedTeacher;
  int? selectedTeacherId;
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final List<DropdownMenuItem<int>> classItems = [];
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
      List classes = jsonDecode(response.body)['data'];
      for (var item in classes) {
        setState(() {
          classItems.add(
            DropdownMenuItem(value: item['id'], child: Text(item['name'])),
          );
        });
      }
    } else {
      throw Exception('error');
    }
  }

  final List<DropdownMenuItem<int>> subjectItems = [];
  List subjects = [];
  getSubjects() async {
    final url = Uri.parse('$baseUrl/api/subjects');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      subjects = jsonDecode(response.body)['data'];
      for (var item in subjects) {
        setState(() {
          subjectItems.add(
            DropdownMenuItem(value: item['id'], child: Text(item['name'])),
          );
        });
      }
    } else {
      throw Exception('error');
    }
  }

  final List<DropdownMenuItem<int>> teacherItems = [];
  getTeachers() async {
    final url = Uri.parse(
      '$baseUrl/api/accounts?Pagesize=500&Where%5Brole%5D=Teacher',
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
          teacherItems.add(
            DropdownMenuItem(value: item['id'], child: Text(item['name'])),
          );
        });
      }
    } else {
      throw Exception('error');
    }
  }

  String selectedDay = 'Saturday';
  int selectedDayIndex = 0;
  final List<String> days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  bool isDayListVisible = false;

  bool showForm = false;
  bool isEdit = false;
  String? editingId;

  void openForm({TimeTableEntity? entity}) {
    String? start;
    String? end;
    if (entity != null) {
      DateFormat inputFormat = DateFormat('HH:mm:ss');
      DateFormat ouputFormat = DateFormat('h:mm a');
      DateTime dateTimeStart = inputFormat.parse(entity.startTime);
      DateTime dateTimeEnd = inputFormat.parse(entity.endTime);

      start = ouputFormat.format(dateTimeStart);
      end = ouputFormat.format(dateTimeEnd);
    }
    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;
      selectedClass = entity?.selectedClass;
      selectedClassId = entity?.selectedClassId;
      selectedSubject = entity?.selectedSubject;
      selectedSubjectId = entity?.selectedSubjectId;
      selectedTeacher = entity?.selectedTeacher;
      selectedTeacherId = entity?.selectedTeacherId;
      startTimeController.text = start ?? '';
      endTimeController.text = end ?? '';
    });
  }

  void resetForm() {
    setState(() {
      showForm = false;
      isEdit = false;
      editingId = null;
      selectedClass = null;
      selectedSubject = null;
      selectedTeacher = null;
      selectedClassId = null;
      selectedSubjectId = null;
      selectedTeacherId = null;
      startTimeController.clear();
      endTimeController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    getSubjects();
    getTeachers();
    getClasses();
    context.read<AddTimeTableCubit>().loadTimeTables(selectedDayIndex);
  }

  @override
  void dispose() {
    selectedClass = null;
    selectedSubject = null;
    selectedTeacher = null;
    startTimeController.clear();
    endTimeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Time Tables"),
      body:
          showForm
              ? SingleChildScrollView(
                child: CreateNewWidget(
                  title: isEdit ? "Edit Time Table" : "Add Time Table",
                  items: [
                    ClassDropdownWidget2(
                      title: "Class",
                      items: classItems,
                      selectedValue: selectedClassId,
                      onChanged:
                          (value) => setState(() => selectedClassId = value),
                    ),
                    const SizedBox(height: 12),
                    ClassDropdownWidget2(
                      title: "Subject",
                      items: subjectItems,
                      selectedValue: selectedSubjectId,
                      onChanged:
                          (value) => setState(() => selectedSubjectId = value),
                    ),
                    const SizedBox(height: 12),
                    ClassDropdownWidget2(
                      title: "Teacher",
                      items: teacherItems,
                      selectedValue: selectedTeacherId,
                      onChanged:
                          (value) => setState(() => selectedTeacherId = value),
                    ),
                    CustomField(
                      label: "Start Time",
                      controller: startTimeController,
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            startTimeController.text = pickedTime.format(
                              context,
                            );
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomField(
                      label: "End Time",
                      controller: endTimeController,
                      readOnly: true,
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            endTimeController.text = pickedTime.format(context);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    CreateButton(
                      label: isEdit ? "Update" : "Create",
                      icon: isEdit ? Icons.restart_alt : Icons.add,
                      enabled:
                          selectedClassId != null &&
                          selectedSubjectId != null &&
                          selectedTeacherId != null &&
                          startTimeController.text.isNotEmpty &&
                          endTimeController.text.isNotEmpty,
                      onPressed: () {
                        final entity = TimeTableEntity(
                          id: isEdit ? editingId! : const Uuid().v4(),
                          selectedClass: selectedClass ?? '',
                          selectedClassId: selectedClassId ?? 0,
                          selectedSubject: selectedSubject ?? '',
                          selectedSubjectId: selectedSubjectId ?? 0,
                          selectedTeacher: selectedTeacher ?? '',
                          selectedTeacherId: selectedTeacherId ?? 0,
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
                          day: selectedDayIndex,
                        );

                        if (isEdit) {
                          context.read<AddTimeTableCubit>().updateTimeTable(
                            entity,
                          );
                        } else {
                          context.read<AddTimeTableCubit>().addTimeTable(
                            entity,
                          );
                        }

                        resetForm();
                      },
                    ),
                  ],
                ),
              )
              : BlocBuilder<AddTimeTableCubit, AddTimeTableState>(
                builder: (context, state) {
                  final timeTablesList = state.timeTables;
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DaySelectorWidget(
                            selectedDay: selectedDay,
                            isDayListVisible: isDayListVisible,
                            onTap: () {
                              setState(() {
                                isDayListVisible = !isDayListVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: const SizedBox(height: 15)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child:
                                isDayListVisible
                                    ? DaysListWidget(
                                      days: days,
                                      selectedDay: selectedDay,
                                      onDaySelected: (day, index) {
                                        setState(() {
                                          selectedDay = day;
                                          selectedDayIndex = index;
                                          isDayListVisible = false;
                                          context
                                              .read<AddTimeTableCubit>()
                                              .loadTimeTables(selectedDayIndex);
                                        });
                                      },
                                    )
                                    : const SizedBox.shrink(),
                          ),
                        ),
                      ),
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
                            final item = timeTablesList[index];
                            return NewWidget(
                              title: RichText(
                                text: TextSpan(
                                  text: item.selectedClass,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              subtitle: "",
                              onEdit: () => openForm(entity: item),
                              onDelete:
                                  () => confirmDelete(
                                    context,
                                    title: "Delete",
                                    message:
                                        "Are you sure you want to delete this time table?",
                                    onConfirm: () {
                                      context
                                          .read<AddTimeTableCubit>()
                                          .deleteTimeTable(item.id);
                                    },
                                  ),
                            );
                          }, childCount: timeTablesList.length),
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

class ClassDropdownWidget2 extends StatelessWidget {
  final int? selectedValue;
  final List<DropdownMenuItem<int>> items;
  final ValueChanged<int?> onChanged;
  final String title;

  const ClassDropdownWidget2({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownButtonFormField<int>(
        value:
            items.any((item) => item.value == selectedValue)
                ? selectedValue
                : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF361FC2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(title, style: TextStyle(color: Colors.white)),
          ),
        ),
        items: items,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: true,
      ),
    );
  }
}
