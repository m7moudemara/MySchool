import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});
  static final String id = '/AttendanceView';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Calendar'),
        centerTitle: true,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Calendar Section
              CalendarWidget(),
              SizedBox(height: 24),
              
              // Stats Section
              StatsSummary(),
              SizedBox(height: 24),
              
              // Attendance Details
              AttendanceDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;
  final Map<DateTime, bool> _attendanceData = {};

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();
    _generateMockData();
  }

  void _generateMockData() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    
    for (var day = firstDay.day; day <= lastDay.day; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      _attendanceData[date] = day % 3 != 0; // Mock data
    }
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
      _generateMockData();
    });
  }

  void _prevMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
      _generateMockData();
    });
  }

  void _goToToday() {
    setState(() {
      _currentMonth = DateTime.now();
      _selectedDate = DateTime.now();
      _generateMockData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    final firstWeekday = firstDay.weekday % 7;

    return Card(
      
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Month Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _prevMonth,
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(_currentMonth),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: _goToToday,
                        child: const Text('Today'),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ),
            
            // Weekday Labels
            const Row(
              children: [
                Expanded(child: Center(child: Text('Sun', style: _weekdayStyle))),
                Expanded(child: Center(child: Text('Mon', style: _weekdayStyle))),
                Expanded(child: Center(child: Text('Tue', style: _weekdayStyle))),
                Expanded(child: Center(child: Text('Wed', style: _weekdayStyle))),
                Expanded(child: Center(child: Text('Thu', style: _weekdayStyle))),
                Expanded(child: Center(child: Text('Fri', style: _weekdayStyle))),
                Expanded(child: Center(child: Text('Sat', style: _weekdayStyle))),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Days Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: firstWeekday + daysInMonth,
              itemBuilder: (context, index) {
                if (index < firstWeekday) {
                  return const SizedBox.shrink();
                }
                
                final day = index - firstWeekday + 1;
                final date = DateTime(_currentMonth.year, _currentMonth.month, day);
                final isPresent = _attendanceData[date] ?? false;
                final isSelected = _selectedDate != null && 
                    _selectedDate!.year == date.year && 
                    _selectedDate!.month == date.month && 
                    _selectedDate!.day == date.day;
                final isToday = date.year == DateTime.now().year && 
                    date.month == DateTime.now().month && 
                    date.day == DateTime.now().day;
                
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: _DayCell(
                    day: day,
                    isPresent: isPresent,
                    isSelected: isSelected,
                    isToday: isToday,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool isPresent;
  final bool isSelected;
  final bool isToday;

  const _DayCell({
    required this.day,
    required this.isPresent,
    required this.isSelected,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[100] : null,
        shape: BoxShape.circle,
        border: isToday ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$day',
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPresent ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class StatsSummary extends StatelessWidget {
  const StatsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatCard(
          value: '24',
          label: 'Present',
          color: Colors.green,
          icon: Icons.check_circle,
        ),
        _StatCard(
          value: '5',
          label: 'Absent',
          color: Colors.red,
          icon: Icons.cancel,
        ),
        _StatCard(
          value: '92%',
          label: 'Attendance',
          color: Colors.blue,
          icon: Icons.bar_chart,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceDetails extends StatelessWidget {
  const AttendanceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Attendance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildAttendanceRow('Today', true, '09:00 AM'),
            _buildAttendanceRow('Yesterday', true, '08:55 AM'),
            _buildAttendanceRow('Monday', false, 'Absent'),
            _buildAttendanceRow('Last Friday', true, '09:10 AM'),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceRow(String day, bool isPresent, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPresent ? Colors.green : Colors.red,
            ),
            child: Icon(
              isPresent ? Icons.check : Icons.close,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            time,
            style: TextStyle(
              color: isPresent ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

const _weekdayStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);