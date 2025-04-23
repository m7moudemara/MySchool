import 'package:MySchool/features/school/presentation/views/result_view.dart';
import 'package:MySchool/features/school/presentation/views/student/attendance_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_homework_view.dart';
import 'package:flutter/material.dart';

class ClassesinfoView extends StatelessWidget {
  static const String id = "/ClassesinfoView";
  const ClassesinfoView({
    super.key,
    required this.studentName,
    required this.studentClass,
  });
  final String studentName;
  final String studentClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      'Classes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 20),

                // User profile section
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: NetworkImage("https://placehold.co/40x40"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentName,
                          style: TextStyle(
                            color: Color(0xFF2F394B),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.03,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          studentClass,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Stats cards - using GridView for responsiveness
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    // Attendance card
                    _buildStatCard(
                      value: '89%',
                      label: 'Attendance',
                      color: const Color(0xFFB45309),
                    ),

                    // Results card
                    _buildStatCard(
                      value: '95%',
                      label: 'Results',
                      color: const Color(0xFF4178D4),
                    ),

                    // Homework card
                    _buildStatCard(
                      value: '18',
                      label: 'Homework',
                      color: const Color(0xFF52B6DF),
                    ),

                    // Total Subjects card
                    _buildStatCard(
                      value: '10',
                      label: 'Total Subject',
                      color: const Color(0xFFF59E0B),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Menu items
                _buildMenuItem(
                  icon: Icons.assignment,
                  title: 'Results',
                  onTap: () {
                  Navigator.pushNamed(context, ResultView.id);
                  },
                ),

                _buildMenuItem(
                  icon: Icons.calendar_today,
                  title: 'Attendance',
                  onTap: () {
                    Navigator.pushNamed(context, AttendanceView.id);
                  },
                ),

                _buildMenuItem(
                  icon: Icons.book,
                  title: 'Homework',
                  onTap: () {
                      Navigator.pushNamed(context, TeacherHomeworkView.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x3AA7A7A7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Icon(icon, size: 28, color: const Color(0xFF2F394B)),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF2F394B),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
