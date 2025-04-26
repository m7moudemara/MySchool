import 'package:MySchool/core/constants.dart';
import 'package:flutter/material.dart';

class HomeworkView extends StatefulWidget {
  const HomeworkView({super.key});
  static String id = '/HomeworkView';

  @override
  State<HomeworkView> createState() => _HomeworkViewState();
}

class _HomeworkViewState extends State<HomeworkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        title: const Text('Homework'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildHomeworkItem(
                subject: 'Maths',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      _buildActionButton('Download', onPressed: () {}),
                      const SizedBox(height: 14),
                      _buildActionButton('Upload', onPressed: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'English',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      _buildActionButton('Download', onPressed: () {}),
                      const SizedBox(height: 14),
                      _buildActionButton('Upload', onPressed: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'Science',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: SizedBox(
                  width: 100, 
                  child: Column(
                    children: [
                      _buildActionButton('Download', onPressed: () {}),
                      const SizedBox(height: 14),
                      _buildActionButton('Upload', onPressed: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'Arabic',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      _buildActionButton('Download', onPressed: () {}),
                      const SizedBox(height: 14),
                      _buildActionButton('Upload', onPressed: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'History',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: SizedBox(
                  width: 100, 
                  child: Column(
                    children: [
                      _buildActionButton('Download', onPressed: () {}),
                      const SizedBox(height: 14),
                      _buildActionButton('Upload', onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/book.png"),
                    Column(
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              daysLeft,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
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
            button,
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
          backgroundColor: const WidgetStatePropertyAll(AppColors.kSecondaryColor),
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
}