import 'package:flutter/material.dart';

class StudentSubmittedHomeworkView extends StatelessWidget {
  const StudentSubmittedHomeworkView({super.key});
  static const String id = '/StudentSubmittedHomeworkView';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total Homework
                const Text(
                  'Total Homework-24',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                // Stats Cards
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard(
                      width: screenWidth * 0.43,
                      percentage: '5%',
                      label: 'Missing',
                      color: const Color(0xFFF2ABFE),
                    ),
                    _buildStatCard(
                      width: screenWidth * 0.43,
                      percentage: '95%',
                      label: 'Submitted',
                      color: const Color(0xFF4178D4),
                    ),
                  ],
                ),

                // Homework Items
                const SizedBox(height: 56),
                _buildHomeworkItem(
                  subject: 'Science',
                  topic: 'Structure of Atoms',
                  assignDate: '10 Oct 25',
                  status: 'Submitted',
                  statusColor: const Color(0xFF4178D4),
                ),

                const SizedBox(height: 40),
                _buildHomeworkItem(
                  subject: 'Mathematics',
                  topic: 'Surface Areas and Volumes',
                  assignDate: '10 Oct 25',
                  status: 'Submitted',
                  statusColor: const Color(0xFF4178D4),
                ),

                const SizedBox(height: 40),
                _buildHomeworkItem(
                  subject: 'English',
                  topic: 'My Bestfriend Essay',
                  assignDate: '10 Oct 25',
                  status: 'Missing',
                  statusColor: const Color(0xFFF2ABFE),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required double width,
    required String percentage,
    required String label,
    required Color color,
  }) {
    return Container(
      width: width,
      height: 85,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0x3AA7A7A7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            percentage,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.20,
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.69,
              letterSpacing: 0.20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeworkItem({
    required String subject,
    required String topic,
    required String assignDate,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject,
            style: TextStyle(
              color: const Color(0xFF6789CA),
              fontSize: 14,
              fontFamily: 'SourceSansPro',
              fontWeight: FontWeight.w600,
              height: 1.43,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            topic,
            style: const TextStyle(
              color: Color(0xFF313131),
              fontSize: 14,
              fontFamily: 'SourceSansPro',
              fontWeight: FontWeight.w600,
              height: 1.43,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Assign Date',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'SourceSansPro',
                  fontWeight: FontWeight.w400,
                  height: 1.29,
                ),
              ),
              Text(
                assignDate,
                style: const TextStyle(
                  color: Color(0xFF3A3A3A),
                  fontSize: 12.14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.43,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
