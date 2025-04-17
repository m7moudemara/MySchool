import 'package:MySchool/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      appBar: AppBar(title: const Text('Homework'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildCalendarSection(),
              const SizedBox(height: 20),
              _buildHomeworkItem(
                subject: 'Maths',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: Column(
                  children: [
                    _buildActionButton('Download', onPressed: () {}),
                    SizedBox(height: 14),
                    _buildActionButton('Upload', onPressed: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'English',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: Column(
                  children: [
                    _buildActionButton('Download', onPressed: () {}),
                    SizedBox(height: 14),
                    _buildActionButton('Upload', onPressed: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'Science',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                button: Column(
                  children: [
                    _buildActionButton('Download', onPressed: () {}),
                    SizedBox(height: 14),
                    _buildActionButton('Upload', onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    final currentDate = DateTime.now();
    final firstDayOfWeek = currentDate.subtract(
      Duration(days: currentDate.weekday - 1),
    ); // بداية الأسبوع (الاثنين)
    final days = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ]; // يمكن تعديلها حسب احتياجك
    final dates = List.generate(
      7,
      (i) => firstDayOfWeek.add(Duration(days: i)),
    ); 

    return Column(
      children: [
        _buildMonthHeader(currentDate),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final date = dates[index];
              final isToday =
                  date.day == currentDate.day &&
                  date.month ==
                      currentDate.month; 
              return _buildDayCard(
                day: days[index],
                date: date.day.toString(),
                isToday: isToday,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthHeader(DateTime date) {
    final monthName = DateFormat(
      'MMM yyyy',
    ).format(date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {

        }),
        Text(
          monthName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {
          

        }),
      ],
    );
  }

  Widget _buildDayCard({
    required String day,
    required String date,
    bool isToday = false,
  }) {
    return Container(
      width: 66,
      decoration: BoxDecoration(
        color: isToday ? const Color(0xFF0C46C4) : const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isToday ? Colors.white : const Color(0xFF2F2E41),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isToday ? Colors.white : const Color(0xFF2F2E41),
            ),
          ),
        ],
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    return ElevatedButton(
      onPressed: onPressed,

      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.kSecondaryColor),

        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.91,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
