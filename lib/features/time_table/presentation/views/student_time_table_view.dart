import 'package:MySchool/features/time_table/presentation/widgets/time_table_item.dart';
import 'package:MySchool/features/time_table/presentation/widgets/day_selector_widget.dart';
import 'package:MySchool/features/time_table/presentation/widgets/days_list_widget.dart';
import 'package:MySchool/features/time_table/presentation/widgets/time_and_class_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/time_table/presentation/cubits/timetable_cubit.dart';

class StudentTimeTableView extends StatefulWidget {
  const StudentTimeTableView({super.key});
  static const String id = "/StudentTimeTableView";

  @override
  State<StudentTimeTableView> createState() => _StudentTimeTableViewState();
}

class _StudentTimeTableViewState extends State<StudentTimeTableView> {
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
                DaySelectorWidget(
                  selectedDay: selectedDay,
                  isDayListVisible: isDayListVisible,
                  onTap: () {
                    setState(() {
                      isDayListVisible = !isDayListVisible;
                    });
                  },
                ),
                const SizedBox(height: 15),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child:
                      isDayListVisible
                          ? DaysListWidget(
                            days: days,
                            selectedDay: selectedDay,
                            onDaySelected: (day) {
                              setState(() {
                                selectedDay = day;
                                isDayListVisible = false;
                              });
                              context.read<TimeTableCubit>().loadTimetable(day);
                            },
                          )
                          : const SizedBox.shrink(),
                ),
                const SizedBox(height: 15),
                TimeAndClassHeader(),
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
                          Text(
                            'It`s a Holiday',
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
                      return TimeTableItem(
                        space: space,
                        height: height,
                        lesson: lessons[index],
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
}
