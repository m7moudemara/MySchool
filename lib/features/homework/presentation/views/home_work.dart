import 'dart:io';

import 'package:MySchool/features/homework/presentation/views/create_homework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TeacherAssignmentsView extends StatefulWidget {
  const TeacherAssignmentsView({super.key});
  static final String id = '/TeacherAssignmentsView';

  @override
  _TeacherAssignmentsViewState createState() => _TeacherAssignmentsViewState();
}

class _TeacherAssignmentsViewState extends State<TeacherAssignmentsView> {
  @override
void initState() {
  super.initState();
  _removeExpiredHomework();
}

void _removeExpiredHomework() {
  final now = DateTime.now();
  homeworkList.removeWhere((hw) => hw.deadline.isBefore(now));
}

  // Local list of homework items
  // This is a mock data list. In a real application, this data would come from a database or API.
  final List<HomeworkItem> homeworkList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homework',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // create homework button
              InkWell(
                    onTap: () async {
                      final newHomework = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateHomeworkview(),
                        ),
                      );

                      if (newHomework != null && newHomework is HomeworkItem) {
                        setState(() {
                          homeworkList.add(newHomework);
                        });
                      }
                    },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C46C4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Create Homework',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.30,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        cursorHeight: 16,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.people_outline),
                          hintText: 'Class',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        cursorHeight: 16,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Homework list
              Expanded(
                child: ListView.builder(
                  itemCount: homeworkList.length,
                  itemBuilder: (context, index) {
                    return _buildHomeworkItem(homeworkList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build each homework item
  Widget _buildHomeworkItem(HomeworkItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 185,
      decoration: BoxDecoration(
        color: const Color(0xFF0C46C4),
        borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Color(0x7F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),

            Text(
              '${item.assignedStudents} Student assigned',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),

            Text(
              item.subject,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),

            Text(
              item.deadline.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),

            Text(
              'Attachment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(color: const Color(0xFFC9C5C5), thickness: 1, height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (item.attachmentFile != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ViewAttachmentPage(
                                file: item.attachmentFile!,
                              ),
                        ),
                      );
                    }
                  },

                  child: Row(
                    children: [
                      Icon(Icons.remove_red_eye, color: Colors.black, size: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            InkWell(
  onTap: () {
    setState(() {
      homeworkList.remove(item);
    });
  },
  child: Row(
    children: [
      Icon(Icons.delete, color: Colors.black, size: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Text(
          'Delete',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  ),
),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeworkItem {
  final String title;
  final String subject;
  final int assignedStudents;
   final DateTime deadline;
  final PlatformFile? attachmentFile;

  HomeworkItem({
    required this.title,
    required this.subject,
    required this.assignedStudents,
    required this.deadline,
    this.attachmentFile, 
  });
}

class ViewAttachmentPage extends StatelessWidget {
  final PlatformFile file;
  const ViewAttachmentPage({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final isImage = file.extension == 'jpg' || file.extension == 'png';
    return Scaffold(
      appBar: AppBar(title: const Text('Attachment Viewer')),
      body: Center(
        child:
            isImage && file.path != null
                ? Image.file(File(file.path!))
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.insert_drive_file,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(file.name),
                  ],
                ),
      ),
    );
  }
}
