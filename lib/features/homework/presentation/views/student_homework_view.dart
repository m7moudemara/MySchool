import 'dart:io';
import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/core/constants.dart';
import 'package:MySchool/features/homework/data/home_work/home_work_cubit.dart';
import 'package:MySchool/features/homework/data/homework_model.dart';
import 'package:MySchool/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

class StudentHomeworkView extends StatefulWidget {
  const StudentHomeworkView({super.key});
  static String id = '/HomeworkView';

  @override
  State<StudentHomeworkView> createState() => _StudentHomeworkViewState();
}

class _StudentHomeworkViewState extends State<StudentHomeworkView> {
  PlatformFile? attachedFile;
  List<HomeworkModel> homwWorksList = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeWorkCubit>(context).loadHomeWorks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Homework'),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeWorkCubit, HomeWorkState>(
        listener: (context, state) {
          if (state is HomeWorkError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is HomeWorkSubmittedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File has been uploaded succefully')),
            );
          } else if (state is HomeWorkSubmittedError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeWorkLoading) {
            return Center(child: Image.asset('assets/loading.gif'));
          } else if (state is HomeWorkLoaded) {
            homwWorksList = state.homeWorks;
            return returnedList();
          }
          return homwWorksList.isEmpty
              ? Center(child: Image.asset('nodata.gif'))
              : returnedList();
        },
      ),
    );
  }

  Widget _buildHomeworkItem({
    required String subject,
    required String task,
    required String daysLeft,
    required Widget button,
  }) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Padding(

  padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/book.png"),
          const SizedBox(width: 8),
         Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        subject,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          const Icon(Icons.access_time, size: 16),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              daysLeft,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ],
  ),
),

          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: button,
          ),
        ],
      ),
      const SizedBox(height: 12),
      Text(
        task,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
),
    );
  }

  Widget _buildActionButton(String text, {required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(
            AppColors.kSecondaryColor,
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.91,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget returnedList() {
    return ListView.builder(
      itemCount: homwWorksList.length,
      itemBuilder: (context, index) {
        final homework = homwWorksList[index];

        // final eventTime = DateTime.parse(
        //   homework.dueDate.toString(),
        // ); // your future event
        // final now = DateTime.now();

        // final difference = eventTime.difference(now);

        // if (difference.isNegative) {
        //   print("The event has already passed.");
        // } else {
        //   final days = difference.inDays;
        //   final hours = difference.inHours % 24;
        //   final minutes = difference.inMinutes % 60;

        //   print(
        //     "Time left: $days days, $hours hours, $minutes minutes",
        //   );
        // }

        var date2 = DateTime.parse("${homework.dueDate}Z");
        var dateFormat = date2.toLocal();
        // print(dateFormat);
        // print(date2);
        // DateTime eventTime = DateTime.parse(homework.dueDate);
        final dueDate = timeago.format(dateFormat, allowFromNow: true);
        // print(dueDate);
        return homework.is_deadline_passed
            ? SizedBox.shrink()
            : _buildHomeworkItem(
              subject: homework.title,
              task: homework.description,
              daysLeft: dueDate,
              button: SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildActionButton(
                      'Download',
                      onPressed: () async {
                        print(homework.file_path);
                        await fileController.downloadFileUsingHttp(
                          '$baseUrl/files/${homework.file_path}',
                          homework.file_path,
                        );
                        // Handle download action
                      },
                    ),
                    const SizedBox(height: 14),
                    _buildActionButton(
                      'Upload',
                      onPressed: () {
                        // Handle upload action
                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text(
                                        'Upload Image',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.43,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final XFile? image = await ImagePicker()
                                            .pickImage(
                                              source: ImageSource.gallery,
                                            );
                                        if (image != null) {
                                          final file = File(image.path);
                                          final bytes =
                                              await file.readAsBytes();
                                          setState(() {
                                            attachedFile = PlatformFile(
                                              name: image.name,
                                              path: image.path,
                                              size: bytes.length,
                                              bytes: bytes,
                                            );
                                          });
                                          BlocProvider.of<HomeWorkCubit>(
                                            context,
                                          ).submitAssignment(
                                            id: homework.id,
                                            plateFormFile: attachedFile!,
                                          );
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.insert_drive_file,
                                      ),
                                      title: const Text(
                                        'Upload File',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.43,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                              allowMultiple: false,
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'jpg',
                                                'png',
                                                'pdf',
                                                'doc',
                                              ],
                                            );
                                        if (result != null) {
                                          setState(() {
                                            attachedFile = result.files.first;
                                          });
                                          BlocProvider.of<HomeWorkCubit>(
                                            context,
                                          ).submitAssignment(
                                            id: homework.id,
                                            plateFormFile: attachedFile!,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
