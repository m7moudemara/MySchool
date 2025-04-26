import 'dart:io';

import 'package:MySchool/features/homework/presentation/views/home_work.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateHomeworkview extends StatefulWidget {
  const CreateHomeworkview({super.key});
  static final String id = '/CreateHomeworkView';

  @override
  State<CreateHomeworkview> createState() => _CreateHomeworkviewState();
}

class _CreateHomeworkviewState extends State<CreateHomeworkview> {
  PlatformFile? attachedFile;
  String? selectedClass;
  final topicController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0C46C4),
        body: SingleChildScrollView(
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
                            child: const Icon(Icons.close, color: Colors.white),
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
                          _buildInputField(
                            image: "assets/addclass.png",
                            child: DropdownButtonFormField<String>(
                              hint: Text("Class section"),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              items:
                                  [
                                    'Class 1',
                                    'Class 2',
                                    'Class 3',
                                    'Class 4',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                selectedClass = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildInputField(
                            image: "assets/topicname.png",
                            child: TextFormField(
                              controller: topicController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Topic Name',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildInputField(
                            image: "assets/description.png",
                            child: TextFormField(
                              controller: descriptionController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Homework Description',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildInputField(
                            image: "assets/duedate.png",
                            child: TextFormField(
                              controller: dueDateController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Due Date',
                              ),
                              readOnly: true,
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  dueDateController.text =
                                      '${picked.day}/${picked.month}/${picked.year}';
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildInputField(
                            image: "assets/time.png",
                            child: TextFormField(
                              controller: timeController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Time',
                              ),
                              readOnly: true,
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  timeController.text = picked.format(context);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Attachment
                          ElevatedButton.icon(
                            onPressed: () {
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
                                              final XFile? image =
                                                  await ImagePicker().pickImage(
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
                                                  await FilePicker.platform
                                                      .pickFiles(
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
                                                  attachedFile =
                                                      result.files.first;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                              );
                            },
                            icon: const Icon(Icons.attach_file),
                            label: const Text("Attachment"),
                          ),

                          const SizedBox(height: 30),

                          // Submit
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
                                  final dateParts = dueDateController.text
                                      .split('/');
                                  final time = timeController.text;
                                  final parsedTime = TimeOfDay(
                                    hour: int.parse(time.split(':')[0]),
                                    minute: int.parse(
                                      time.split(':')[1].split(' ')[0],
                                    ),
                                  );
                                  final isPM = time.toLowerCase().contains(
                                    'pm',
                                  );

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

                                  final homework = HomeworkItem(
                                    title: topicController.text,
                                    subject: selectedClass ?? 'Unknown',
                                    assignedStudents: 0,
                                    attachmentFile: attachedFile,
                                    deadline: deadline,
                                  );

                                  Navigator.pop(context, homework);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please select a valid date and time.',
                                      ),
                                    ),
                                  );
                                }
                              },

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
