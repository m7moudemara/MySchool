import 'package:MySchool/features/time_table/presentation/widgets/day_selector_widget.dart';
import 'package:MySchool/features/time_table/presentation/widgets/days_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/search_utlis.dart';
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

class AddTimeTableView extends StatefulWidget {
  const AddTimeTableView({super.key});
  static const String id = "/AddTimeTableView";

  @override
  State<AddTimeTableView> createState() => _AddTimeTableViewState();
}

class _AddTimeTableViewState extends State<AddTimeTableView> {
  String? selectedClass;
  String? selectedSubject;
  String? selectedTeacher;
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final List<DropdownMenuItem<String>> gradeItems = [
    DropdownMenuItem(value: 'Grade 1', child: Text('Grade 1')),
    DropdownMenuItem(value: 'Grade 2', child: Text('Grade 2')),
    DropdownMenuItem(value: 'Grade 3', child: Text('Grade 3')),
  ];
  final List<DropdownMenuItem<String>> subjectItems = [
    DropdownMenuItem(value: 'Math', child: Text('Math')),
    DropdownMenuItem(value: 'Science', child: Text('Science')),
    DropdownMenuItem(value: 'English', child: Text('English')),
  ];
  final List<DropdownMenuItem<String>> teacherItems = [
    DropdownMenuItem(value: 'Teacher 1', child: Text('Teacher 1')),
    DropdownMenuItem(value: 'Teacher 2', child: Text('Teacher 2')),
    DropdownMenuItem(value: 'Teacher 3', child: Text('Teacher 3')),
  ];
  String selectedDay = 'Saturday';
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
    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;
      selectedClass = entity?.selectedClass;
      selectedSubject = entity?.selectedSubject;
      selectedTeacher = entity?.selectedTeacher;
      startTimeController.text = entity?.startTime?.toString() ?? '';
      endTimeController.text = entity?.endTime?.toString() ?? '';
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
      startTimeController.clear();
      endTimeController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AddTimeTableCubit>().loadTimeTables();
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
                    ClassDropdownWidget(
                      title: "Class",
                      items: gradeItems,
                      selectedValue: selectedClass,
                      onChanged:
                          (value) => setState(() => selectedClass = value),
                    ),
                    const SizedBox(height: 12),
                    ClassDropdownWidget(
                      title: "Subject",
                      items: subjectItems,
                      selectedValue: selectedSubject,
                      onChanged:
                          (value) => setState(() => selectedSubject = value),
                    ),
                    const SizedBox(height: 12),
                    ClassDropdownWidget(
                      title: "Teacher",
                      items: teacherItems,
                      selectedValue: selectedTeacher,
                      onChanged:
                          (value) => setState(() => selectedTeacher = value),
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
                      icon: isEdit ? Icons.edit : Icons.add,
                      enabled:
                          selectedClass != null &&
                          selectedSubject != null &&
                          selectedTeacher != null &&
                          startTimeController.text.isNotEmpty &&
                          endTimeController.text.isNotEmpty,
                      onPressed: () {
                        final entity = TimeTableEntity(
                          id: isEdit ? editingId! : const Uuid().v4(),
                          selectedClass: selectedClass ?? '',
                          selectedSubject: selectedSubject ?? '',
                          selectedTeacher: selectedTeacher ?? '',
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
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
                                      onDaySelected: (day) {
                                        setState(() {
                                          selectedDay = day;
                                          isDayListVisible = false;
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
