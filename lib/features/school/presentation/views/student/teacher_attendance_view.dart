import 'dart:convert';
import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/size_config.dart';
import 'package:MySchool/features/attendace/progress_circle.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/views/student/attendance_student/attendance_student_cubit.dart';
import 'package:MySchool/features/school/presentation/views/student/data/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/strings.dart';
import '../../../../../main.dart';
import '../../../data/models/student_model.dart';
import 'data/attendence_cubit.dart';

class TeacherAttendanceStudentView extends StatefulWidget {
  final Map student;
  const TeacherAttendanceStudentView({super.key, required this.student});
  static final String id = '/AttendanceView';

  @override
  State<TeacherAttendanceStudentView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<TeacherAttendanceStudentView> {
  late IUser? user;
  Future<List> getStudentAttendance() async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/attendances');
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      List selectedUser =
          result
              .where(
                (element) =>
                    element['student']['id'] == widget.student['account']['id'],
              )
              .toList();

      user = Student.fromJson(result[0]['student']);

      List<AttendanceModel> attendanceData =
          selectedUser
              .map<AttendanceModel>((item) => AttendanceModel.fromJson(item))
              .toList();
      BlocProvider.of<AttendanceStudentCubit>(
        context,
      ).setAttendanceData(attendanceData);
      return result;
    } else {
      throw Exception('error');
    }
  }

  double get absentPercentage {
    final absentDays = user?.absentDays ?? 0.0;
    final totalDays = user?.totalDays ?? 0.0;
    return (totalDays > 0) ? (absentDays / totalDays) * 100 : 0.0;
  }

  double get progressDays => 100 - absentPercentage;

  fetchAttendanceData() async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/attendances');
    final response = await http.get(
      url,
      headers: {
        'Authorization': ' Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final returnedData = jsonDecode(response.body)['data'];
      return returnedData;
    } else {
      // Handle error response
      throw Exception(
        'Failed to fetch attendance data: ${response.statusCode}',
      );
    }
  }

  Future<void> _fetchAttendanceData() async {
    try {
      await getStudentAttendance();
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  @override
  void dispose() {
    super.dispose();
    // BlocProvider.of<UserCubit>(context).clearUser();
  }

  @override
  Widget build(BuildContext context) {
    //! Initialize SizeConfig
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Attendance'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AttendanceStudentCubit, AttendanceStudentState>(
          listener: (context, state) {
            if (state is AttendanceStudentError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is AttendanceStudentLoaded) {
              // Handle successful data load if needed
              print('Attendance data loaded successfully');
            } else {
              // Handle other states if necessary
              print('Current state: $state');
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (state is AttendanceStudentLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is AttendanceStudentError)
                    Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  if (state is AttendanceStudentLoaded)
                    CalendarWidget(
                      // user: user,
                      attendanceData: state.attendances,
                    ),
                  const SizedBox(height: 24),
                  BlocBuilder<AttendenceCubit, AttendenceState>(
                    builder: (context, state) {
                      if (state is AttendenceError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      if (state is AttendencePresentNumberChanged) {
                        return Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.black,
                          child: ProgressCircle(
                            proggress: state.presentNumber.toDouble(),
                            remaining: state.absentNumber.toDouble(),
                            radiusFactor: SizeConfig.screenWidth * 0.3,
                            progressColor: AppColors.kSecondaryColor,
                            remainingColor: AppColors.absentColor,
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendCircle(
                        color: AppColors.kSecondaryColor,
                        text: 'Present',
                      ),
                      const SizedBox(width: 20),
                      _buildLegendCircle(
                        color: AppColors.absentColor,
                        text: 'Absent',
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLegendCircle({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          height: 12,
          width: 12,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key, this.attendanceData});
  // final IUser? user;
  final List<AttendanceModel>? attendanceData;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;
  final Map<DateTime, bool?> _attendanceData = {};
  List<DateTime> selectedDates = [];
  List<DateTime>? getAttendanceData() {
    if (widget.attendanceData != null) {
      List<AttendanceModel> attendanceModels =
          widget.attendanceData!
              .where((item) => item.status == 'Present')
              .toList();
      // List<DateTime> selectedDates = [];

      List<DateTime> attendanceDates =
          attendanceModels.map((e) => DateTime.parse(e.date)).toList();

      for (DateTime datex in attendanceDates) {
        if (mounted) {
          setState(() {
            _attendanceData[datex] =
                datex.month == _currentMonth.month &&
                datex.year == _currentMonth.year;
            if (_attendanceData[datex] == true) {
              selectedDates.add(datex);
            }
          });
        }
      }
      return selectedDates;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();
    _generateMockData();
  }

  int numberOfPresent = 0;
  int numberOfAbsent = 0;
  void _generateMockData() {
    setState(() {
      numberOfPresent = 0;
      numberOfAbsent = 0;
    });
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    _attendanceData.clear();
    for (var day = firstDay.day; day <= lastDay.day; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      if (date.weekday == DateTime.friday) {
        _attendanceData[date] = null; // Friday is a holiday
      } else {
        _attendanceData[date] = getAttendanceData()?.contains(date) ?? false;
        numberOfPresent +=
            _attendanceData[date] == true ? 1 : 0; // Count present days
        numberOfAbsent +=
            _attendanceData[date] == false || _attendanceData[date] == null
                ? 1
                : 0; // Count absent days
      }
    }
    BlocProvider.of<AttendenceCubit>(
      context,
    ).setPresentNumber(numberOfPresent, numberOfAbsent + numberOfPresent);
  }

  int get presentCount => numberOfPresent;
  int get absentCount => numberOfAbsent;
  // _attendanceData.values.where((v) => v == false || v == null).length;
  // int get presentCount => _attendanceData.values.where((v) => v == true).length;
  // int get absentCount => _attendanceData.values.where((v) => v == false).length;

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
      selectedDates.clear();
      _generateMockData();
    });
  }

  void _prevMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
      selectedDates.clear();
      _generateMockData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    final firstWeekday = firstDay.weekday % 7;

    return Column(
      children: [
        // Header
        Card(
          color: Color(0xffD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: _prevMonth,
                        ),
                        Text(
                          DateFormat('MMMM yyyy').format(_currentMonth),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: _nextMonth,
                        ),
                      ],
                    ),
                  ),
                ),

                const Row(
                  children: [
                    Expanded(
                      child: Center(child: Text('Sun', style: _weekdayStyle)),
                    ),
                    Expanded(
                      child: Center(child: Text('Mon', style: _weekdayStyle)),
                    ),
                    Expanded(
                      child: Center(child: Text('Tue', style: _weekdayStyle)),
                    ),
                    Expanded(
                      child: Center(child: Text('Wed', style: _weekdayStyle)),
                    ),
                    Expanded(
                      child: Center(child: Text('Thu', style: _weekdayStyle)),
                    ),
                    Expanded(
                      child: Center(child: Text('Fri', style: _weekdayStyle)),
                    ),
                    Expanded(
                      child: Center(child: Text('Sat', style: _weekdayStyle)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: firstWeekday + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < firstWeekday) return const SizedBox.shrink();

                    final day = index - firstWeekday + 1;
                    final date = DateTime(
                      _currentMonth.year,
                      _currentMonth.month,
                      day,
                    );
                    final isPresent = _attendanceData[date];
                    final isSelected =
                        _selectedDate?.difference(date).inDays == 0 &&
                        _selectedDate?.month == date.month &&
                        _selectedDate?.year == date.year;
                    final now = DateTime.now();
                    final isToday =
                        date.day == now.day &&
                        date.month == now.month &&
                        date.year == now.year;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: _DayCell(
                        day: day,
                        isPresent: isPresent,
                        isToday: isToday,
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        StatsSummary(presentCount: presentCount, absentCount: absentCount),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool? isPresent;
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
    Color borderColor;
    if (isPresent == true) {
      borderColor = AppColors.kSecondaryColor;
    } else if (isPresent == false) {
      borderColor = AppColors.absentColor;
    } else {
      borderColor = Colors.transparent;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: isPresent != null ? 2 : 0,
        ),
        color: isToday ? Colors.blue.withValues(alpha: 0.2) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '$day',
        style: TextStyle(
          color: isPresent == null ? Colors.black : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class StatsSummary extends StatelessWidget {
  final int presentCount;
  final int absentCount;

  const StatsSummary({super.key, this.presentCount = 0, this.absentCount = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatCard(
          value: '$presentCount',
          title: 'Present',
          color: AppColors.kSecondaryColor,
        ),
        _StatCard(
          value: '$absentCount',
          title: 'Absent',
          color: AppColors.absentColor,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String title;
  final Color color;

  const _StatCard({
    required this.value,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

const _weekdayStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
