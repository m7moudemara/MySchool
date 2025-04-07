import 'package:flutter/material.dart';

class HomeworkView extends StatelessWidget {
  const HomeworkView({super.key});
  static String id = '/HomeworkView';

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
                actions: [
                  _buildActionButton('Download', onPressed: () {}),
                  const SizedBox(height: 14),
                  _buildActionButton('Upload', onPressed: () {}),
                ],
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'English',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                actions: [
                  _buildActionButton('Download', onPressed: () {}),
                  const SizedBox(height: 14),
                  _buildActionButton('Upload', onPressed: () {}),
                ],
              ),
              const SizedBox(height: 16),
              _buildHomeworkItem(
                subject: 'Science',
                task: 'Solve the Given problems',
                daysLeft: '1 day left',
                actions: [
                  _buildActionButton('Download', onPressed: () {}),
                  const SizedBox(height: 14),
                  _buildActionButton('Upload', onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    final currentDate = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri'];
    final dates = List.generate(5, (i) => currentDate.day + i);

    return Column(
      children: [
        _buildMonthHeader(),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isToday = index == 2; // Assuming Wednesday is today
              return _buildDayCard(
                day: days[index],
                date: dates[index].toString(),
                isToday: isToday,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
        const Text(
          'Jan 2025',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
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
              fontSize: 16,
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
    required List<Widget> actions,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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

          Column(children: actions),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0C46C4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
