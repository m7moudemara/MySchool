import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/domain/entities/subject_entity.dart';
import 'package:MySchool/features/admin/presentation/cubits/subject_cubits/add_subject_cubit.dart';
import 'package:MySchool/features/admin/presentation/widgets/add_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_button.dart';
import 'package:MySchool/features/admin/presentation/widgets/create_new_widget.dart';
import 'package:MySchool/features/admin/presentation/widgets/custom_text_feild.dart';
import 'package:MySchool/features/admin/presentation/widgets/new_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddSubjectView extends StatefulWidget {
  const AddSubjectView({super.key});
  static const String id = "/SubjectView";

  @override
  State<AddSubjectView> createState() => _AddSubjectViewState();
}

class _AddSubjectViewState extends State<AddSubjectView> {
  final TextEditingController subjectNameController = TextEditingController();
  bool showForm = false;
  bool isEdit = false;
  String? editingId;

  void openForm({SubjectEntity? entity}) {
    setState(() {
      showForm = true;
      isEdit = entity != null;
      editingId = entity?.id;
      subjectNameController.text = entity?.name ?? '';
    });
  }

  void resetForm() {
    setState(() {
      showForm = false;
      isEdit = false;
      editingId = null;
      subjectNameController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<AddSubjectCubit>().loadSubjects();

    subjectNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    subjectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Subjects"),
      body:
          showForm
              ? CreateNewWidget(
                items: [
                  CustomField(
                    controller: subjectNameController,
                    label: "Subject Name",
                  ),
                  CreateButton(
                    label: isEdit ? "Update " : "Create ",
                    icon: isEdit ? Icons.restart_alt : Icons.add,
                    enabled: subjectNameController.text.isNotEmpty,
                    onPressed: () {
                      final entity = SubjectEntity(
                        id: isEdit ? editingId! : const Uuid().v4(),
                        name: subjectNameController.text,
                      );

                      if (isEdit) {
                        context.read<AddSubjectCubit>().updateSubject(entity);
                      } else {
                        context.read<AddSubjectCubit>().addSubject(entity);
                      }
                      resetForm();
                    },
                  ),
                ],
                title: isEdit ? "Edit Subject" : "Add Subject",
              )
              : BlocBuilder<AddSubjectCubit, AddSubjectState>(
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: AddWidget(
                          onTap: () => openForm(),
                          title: "Add Subject",
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
                            final item = state.subject[index];
                            return NewWidget(
                              title: RichText(
                                text: TextSpan(
                                  text: item.name,
                                  style: DefaultTextStyle.of(context).style,
                                ),
                              ),
                              subtitle: '',
                              onEdit: () => openForm(entity: item),
                              onDelete:
                                  () => confirmDelete(
                                    context,
                                    title: "Delete",
                                    message:
                                        "Are you sure you want to delete this subject?",
                                    onConfirm: () {
                                      context
                                          .read<AddSubjectCubit>()
                                          .deleteSubject(item.id);
                                    },
                                  ),
                            );
                          }, childCount: state.subject.length),
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
