import 'package:flutter/material.dart';

class DaysListWidget extends StatelessWidget {
  final List<String> days;
  final String selectedDay;
  final Function(String day,int index) onDaySelected;

  const DaysListWidget({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children:
              days.asMap().entries.map((day) {
                return GestureDetector(
                  onTap: () => onDaySelected(day.value,day.key),
                  child: Container(
                    width: double.infinity,
                    color:
                        day == selectedDay
                            ? const Color(0xff103568).withOpacity(0.1)
                            : Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      day.value,
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
}
