import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/domain/entities/class_entity.dart';
import 'package:MySchool/features/admin/presentation/cubits/class_cubits/add_class_cubit.dart';
import 'package:MySchool/features/admin/presentation/widgets/add_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/class_dropdown_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_button.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_new_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/custom_text_feild.dart';
import 'package:MySchool/features/admin/presentation/widgets/new_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddClassView extends StatefulWidget {
  const AddClassView({super.key});
  static const String id = "/ClassView";

  @override
  State<AddClassView> createState() => _AddClassViewState();
}

class _AddClassViewState extends State<AddClassView> {
  final TextEditingController classNameController = TextEditingController();
  String? selectedGrade;
  bool showForm = false;
  bool isEdit = false;
  String? editingId;
  List<ClassEntity> classes = [];
  final List<DropdownMenuItem<String>> gradeItems = [
    DropdownMenuItem(value: "Grade 1", child: Text("grade 1")),
    DropdownMenuItem(value: "Grade 2", child: Text("grade 2")),
    DropdownMenuItem(value: "Grade 3", child: Text("grade 3")),
    DropdownMenuItem(value: "Grade 4", child: Text("grade 4")),
    DropdownMenuItem(value: "Grade 5", child: Text("grade 5")),
    DropdownMenuItem(value: "Grade 6", child: Text("grade 6")),
    DropdownMenuItem(value: "Grade 7", child: Text("grade 7")),
    DropdownMenuItem(value: "Grade 8", child: Text("grade 8")),
    DropdownMenuItem(value: "Grade 9", child: Text("grade 9")),
    DropdownMenuItem(value: "Grade 10", child: Text("grade 10")),
    DropdownMenuItem(value: "Grade 11", child: Text("grade 11")),
    DropdownMenuItem(value: "Grade 12", child: Text("grade 12")),
  ];

  void openForm({ClassEntity? entity}) {
    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;
      classNameController.text = entity?.name ?? '';
      selectedGrade = "Grade ${entity?.grade}";
      // selectedGrade = entity?.grade;
    });
  }

  void resetForm() {
    setState(() {
      showForm = false;
      isEdit = false;
      editingId = null;
      classNameController.clear();
      selectedGrade = null;
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<AddClassCubit>().loadClasses();

    classNameController.addListener(() {
      setState(() {});
    });
    selectedGrade = null;
  }

  @override
  void dispose() {
    classNameController.dispose();
    selectedGrade = null;
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
                  CustomField(
                    controller: classNameController,
                    label: "Class Name",
                  ),
                  ClassDropdownWidget(
                    title: "select grade",
                    items: gradeItems,
                    selectedValue: selectedGrade,
                    onChanged: (value) => setState(() => selectedGrade = value),
                  ),
                  CreateButton(
                    label: isEdit ? "Update " : "Create ",
                    icon: isEdit ? Icons.restart_alt : Icons.add,
                    enabled:
                        classNameController.text.isNotEmpty &&
                        selectedGrade != null,
                    onPressed: () {
                      final entity = ClassEntity(
                        id: isEdit ? editingId! : const Uuid().v4(),
                        name: classNameController.text,
                        grade: selectedGrade!,

                        studentsCount: 20,
                      );

                      if (isEdit) {
                        context.read<AddClassCubit>().updateClass(entity);
                      } else {
                        context.read<AddClassCubit>().addClass(entity);
                      }
                      resetForm();
                    },
                  ),
                ],
              )
              : BlocBuilder<AddClassCubit, AddClassState>(
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
                            final item = state.classes[index];
                            return NewWidget(
                              title: RichText(
                                text: TextSpan(
                                  text: item.name,
                                  style: DefaultTextStyle.of(context).style,
                                ),
                              ),
                              subtitle: item.grade,
                              onEdit: () => openForm(entity: item),
                              onDelete:
                                  () => confirmDelete(
                                    context,
                                    title: "Delete",
                                    message:
                                        "Are you sure you want to delete this Teacher?",
                                    onConfirm: () {
                                      context.read<AddClassCubit>().deleteClass(
                                        item.id,
                                      );
                                    },
                                  ),
                            );
                          }, childCount: state.classes.length),
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
