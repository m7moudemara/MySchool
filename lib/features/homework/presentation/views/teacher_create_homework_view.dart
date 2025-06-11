import 'dart:io';
import 'package:MySchool/core/widgets/custom_snack_bar.dart';
import 'package:MySchool/features/homework/data/teacher/cubit/teacher_home_work_cubit.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_class_model.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_subject_model.dart';
import 'package:MySchool/features/homework/presentation/views/teacher_homework_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class TeacherCreateHomeworkview extends StatefulWidget {
  const TeacherCreateHomeworkview({super.key});
  static final String id = '/CreateHomeworkView';

  @override
  State<TeacherCreateHomeworkview> createState() =>
      _TeacherCreateHomeworkviewState();
}

class _TeacherCreateHomeworkviewState extends State<TeacherCreateHomeworkview> {
  PlatformFile? attachedFile;
  TeacherClassModel? selectedClass;
  TeacherSubjectModel? selectedSubject;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TeacherHomeWorkCubit>(context).fetchTeacherClasses();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0C46C4),
        body: BlocConsumer<TeacherHomeWorkCubit, TeacherHomeWorkState>(
          listener: (context, state) {
            if (state is HomeWorkUploaded) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TeacherHomeworkView()),
              );
              // Navigator.pop(context);
            } else if (state is HomeWorkUploadedError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is TeacherClassLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TeacherClassLoaded) {
              List<TeacherClassModel> classes = state.classes;
              List<TeacherSubjectModel> subjects = state.subjects;
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          color: const Color(0xFF0C46C4),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          color: Colors.white,
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 4,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Create Homework',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                //! Homework Title
                                _buildInputField(
                                  image: "assets/addclass.png",
                                  child: TextFormField(
                                    controller:
                                        context
                                            .read<TeacherHomeWorkCubit>()
                                            .homeworkTitleController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Homework Title',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                //! Subjects
                                _buildInputField(
                                  image: "assets/classSection.png",
                                  child: DropdownButtonFormField<
                                    TeacherSubjectModel
                                  >(
                                    hint: Text("Subject"),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    items:
                                        // [
                                        //   'Subject 1',
                                        //   'Subject 2',
                                        //   'Subject 3',
                                        //   'Subject 4',
                                        //   'Subject 5',
                                        // ]
                                        subjects.map((
                                          TeacherSubjectModel value,
                                        ) {
                                          return DropdownMenuItem<
                                            TeacherSubjectModel
                                          >(
                                            value: value,
                                            child: Text(value.name),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      selectedSubject = value;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                //! Class Section
                                _buildInputField(
                                  image: "assets/Section.png",
                                  child: DropdownButtonFormField<
                                    TeacherClassModel
                                  >(
                                    hint: Text("Class Section"),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    items:
                                        classes.map((TeacherClassModel value) {
                                          return DropdownMenuItem<
                                            TeacherClassModel
                                          >(
                                            value:
                                                value, // or value.name if you want to use the class name as the value
                                            child: Text('Class ${value.name}'),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      selectedClass = value;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                //! Start Time
                                _buildInputField(
                                  image: "assets/duedate.png",
                                  child: TextFormField(
                                    controller:
                                        context
                                            .read<TeacherHomeWorkCubit>()
                                            .startTimeController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Start Time',
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                          );
                                      if (picked != null) {
                                        context
                                                .read<TeacherHomeWorkCubit>()
                                                .startTimeController
                                                .text =
                                            '${picked.day}/${picked.month}/${picked.year}';
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                //! End Time
                                _buildInputField(
                                  image: "assets/time.png",
                                  child: TextFormField(
                                    controller:
                                        context
                                            .read<TeacherHomeWorkCubit>()
                                            .endTimeController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'End Time',
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      final TimeOfDay? picked =
                                          await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                      if (picked != null) {
                                        context
                                            .read<TeacherHomeWorkCubit>()
                                            .endTimeController
                                            .text = picked.format(context);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),

                                //! Attachment
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                      side: WidgetStateProperty.all(
                                        BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (_) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.image,
                                                    ),
                                                    title: const Text(
                                                      'Upload Image',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.43,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      final XFile? image =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery,
                                                              );
                                                      if (image != null) {
                                                        final file = File(
                                                          image.path,
                                                        );
                                                        final bytes =
                                                            await file
                                                                .readAsBytes();
                                                        setState(() {
                                                          attachedFile =
                                                              PlatformFile(
                                                                name:
                                                                    image.name,
                                                                path:
                                                                    image.path,
                                                                size:
                                                                    bytes
                                                                        .length,
                                                                bytes: bytes,
                                                              );
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.insert_drive_file,
                                                    ),
                                                    title: const Text(
                                                      'Upload File',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.43,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      FilePickerResult?
                                                      result = await FilePicker
                                                          .platform
                                                          .pickFiles(
                                                            allowMultiple:
                                                                false,
                                                            type:
                                                                FileType.custom,
                                                            allowedExtensions: [
                                                              'jpg',
                                                              'png',
                                                              'pdf',
                                                              'doc',
                                                            ],
                                                          );
                                                      if (result != null) {
                                                        setState(() {
                                                          attachedFile =
                                                              result
                                                                  .files
                                                                  .first;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.attach_file,
                                      color: Colors.black,
                                    ),
                                    label: const Text(
                                      "Attachment",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),

                                //! Submit
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0C46C4),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      try {
                                        final dateParts = context
                                            .read<TeacherHomeWorkCubit>()
                                            .startTimeController
                                            .text
                                            .split('/');
                                        final time =
                                            context
                                                .read<TeacherHomeWorkCubit>()
                                                .endTimeController
                                                .text;
                                        final parsedTime = TimeOfDay(
                                          hour: int.parse(time.split(':')[0]),
                                          minute: int.parse(
                                            time.split(':')[1].split(' ')[0],
                                          ),
                                        );
                                        final isPM = time
                                            .toLowerCase()
                                            .contains('pm');

                                        int hour = parsedTime.hour;
                                        if (isPM && hour < 12) hour += 12;
                                        if (!isPM && hour == 12) hour = 0;

                                        final deadline = DateTime(
                                          int.parse(dateParts[2]),
                                          int.parse(dateParts[1]),
                                          int.parse(dateParts[0]),
                                          hour,
                                          parsedTime.minute,
                                        );

                                        // final homework = HomeworkEntity(
                                        //   title:
                                        //       context
                                        //           .read<TeacherHomeWorkCubit>()
                                        //           .homeworkTitleController
                                        //           .text,
                                        //   subject:
                                        //       selectedSubject?.name ??
                                        //       'Unknown',
                                        //   attachmentFile: attachedFile,
                                        //   deadline: deadline,
                                        // );
                                        context
                                            .read<TeacherHomeWorkCubit>()
                                            .pushHomeWorkToServer(
                                              subject: selectedSubject!,
                                              classx: selectedClass!,
                                              plateFormFile: attachedFile!,
                                              deadline: deadline,
                                            );
                                        // Navigator.pop(context, homework);
                                      } catch (e) {
                                        CustomSnackBar.show(
                                          context,
                                          "Required Start and End Time",
                                          type: SnackBarType.error,
                                        );
                                      }
                                    },
                                    //! Button
                                    child: const Text(
                                      'Share Homework',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInputField({required Widget child, required String image}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Image.asset(image, height: 24, width: 24),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF0C46C4)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
