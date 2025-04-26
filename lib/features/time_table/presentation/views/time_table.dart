import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';
import 'package:MySchool/features/time_table/presentation/cubits/timetable_cubit.dart';

class TimeTableView extends StatefulWidget {
  const TimeTableView({super.key});
  static const String id = "/TimeTableView";

  @override
  State<TimeTableView> createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  double space = 30;
  double height = 60;

  String selectedDay = 'Saturday';
  final List<String> days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  bool isDayListVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<TimeTableCubit>().loadTimetable(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Timetable',
          style: TextStyle(
            color: Color(0xff103568),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDaySelector(),
                const SizedBox(height: 15),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: isDayListVisible ? _buildDaysList() : const SizedBox.shrink(),
                ),
                const SizedBox(height: 15),
                _buildTimeAndClass(),
              ],
            ),
          ),
       Expanded(
  child: BlocBuilder<TimeTableCubit, TimeTableState>(
    builder: (context, state) {
      
      if (selectedDay == 'Friday') {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/holiday.png',  
                  width: 300,            
                  fit: BoxFit.contain,    
                ),
                Text('It`s a Holiday',
                     textAlign: TextAlign.center,
                
                style: TextStyle(
                    color: const Color(0xFF0C46C4),
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.30,
                ),
                ),
            
              ],
            ),
          ),
        );
      }

      
      if (state is TimeTableLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TimeTableLoaded) {
        final lessons = state.lessons;
        return ListView.builder(
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            return buildCombinedTimetable(
              lessons[index],
              isFirstItem: index == 0,
              isLastItem: index == lessons.length - 1,
            );
          },
        );
      } else if (state is TimeTableError) {
        return Center(child: Text(state.message));
      } else {
        return const SizedBox.shrink();
      }
    },
  ),
),
        ],
      ),
    );
  }

  Widget buildCombinedTimetable(
    LessonEntity lesson, {
    bool isFirstItem = false,
    bool isLastItem = false,
  }) {
    const startTimeStyle = TextStyle(
      color: Colors.black,
      fontSize: 15.16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );

    const endTimeStyle = TextStyle(
      color: Color(0xFFBAB7C9),
      fontSize: 10.11,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: height / 4),
              Padding(
                padding: EdgeInsets.only(bottom: space,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(lesson.time, style: startTimeStyle),
                    Text(lesson.endTime, style: endTimeStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: height / 2,
              child: isFirstItem ? null : Container(width: 2, color: const Color(0xff3620C2)),
            ),
            Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xff3620C2),
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLastItem)
                  Container(
                    width: 2,
                    height: space + (height / 2),
                    color: const Color(0xff3620C2),
                  ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 240,
                height: height,
                decoration: ShapeDecoration(
                  color: lesson.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.74),
                  ),
                ),
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      lesson.isBreak ? Icons.free_breakfast : Icons.person,
                      color: const Color(0xFF3C3C3C),
                    ),
                    title: Text(
                      lesson.subject,
                      style: const TextStyle(
                        color: Color(0xFF3C3C3C),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: !lesson.isBreak
                        ? Text(
                            lesson.teacher,
                            style: const TextStyle(
                              color: Color(0xFF5F5F5F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDaySelector() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDayListVisible = !isDayListVisible;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDay,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              isDayListVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: const Color(0xff103568),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysList() {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: days.map((day) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDay = day;
                  isDayListVisible = false;
                });
                context.read<TimeTableCubit>().loadTimetable(selectedDay);
              },
              child: Container(
                width: double.infinity,
                color: day == selectedDay
                    ? const Color(0xff103568).withOpacity(0.1)
                    : Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  day,
                  style: TextStyle(
                    color: day == selectedDay ? Colors.black : Colors.grey,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTimeAndClass() {
    const headerStyle = TextStyle(
      color: Color(0xFF3C3C3C),
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    );
    return Row(
      children: const [
        Text("Time", style: headerStyle),
        SizedBox(width: 50),
        Text("Class", style: headerStyle),
      ],
    );
  }
}
