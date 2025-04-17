import 'package:flutter/material.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});
  static String id = '/AttendanceView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTimeDisplay(),
            const SizedBox(height: 16),
            _buildMonthSelector(),
            const SizedBox(height: 16),
            _buildCalendarGrid(),
            const SizedBox(height: 24),
            _buildAttendanceStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDisplay() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '10:42',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      width: double.infinity,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF103568),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFAA5DDB),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'April, 2025',
          style: TextStyle(
            color: Color(0xFFFFFDFD),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF5973C0),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x7F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
        
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(14, (index) => _buildDayIndicator(isPresent: true)),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildDayIndicator(isPresent: true),
              _buildDayIndicator(isPresent: true),
              _buildDayIndicator(isPresent: true),
              _buildDayIndicator(isPresent: false),
              _buildDayIndicator(isPresent: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayIndicator({required bool isPresent}) {
    return Container(
      width: 22,
      height: 23,
      decoration: ShapeDecoration(
        color: isPresent ? const Color(0xFF068440) : const Color(0xFFF9A6A6),
        shape: const OvalBorder(),
      ),
    );
  }

  Widget _buildAttendanceStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard(
          count: '15',
          label: 'Present',
          color: const Color(0xFF70D9A0),
        ),
        _buildStatCard(
          count: '2',
          label: 'Absent',
          color: const Color(0xFFF9A6A6),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String count,
    required String label,
    required Color color,
  }) {
    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
          ),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0xB2000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}