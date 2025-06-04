import 'package:MySchool/features/grades/presentation/widgets/image_section.dart';
import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final String studentName;
  final String className;
  final String imageUrl;
  final List<Map<String, String>> subjects;
  final String totalMarks;
  final String overallPercentage;
  final String overallGrade;

  const ResultItem({
    super.key,
    required this.studentName,
    required this.className,
    required this.imageUrl,
    required this.subjects,
    required this.totalMarks,
    required this.overallPercentage,
    required this.overallGrade,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Profile section
        ImageSection(
          imageUrl: imageUrl,
          studentName: studentName,
          className: className,
        ),
        const SizedBox(height: 20),
        //! Header
        _header(),
        const SizedBox(height: 10),
        //! Subject marks
        ...subjects.map(
          (subject) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    subject['name'] ?? '',
                    style: const TextStyle(fontFamily: 'League Spartan'),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      subject['mark'] ?? '',
                      style: const TextStyle(fontFamily: 'League Spartan'),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      subject['grade'] ?? '',
                      style: const TextStyle(fontFamily: 'League Spartan'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //! Summary
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0x540C46C4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Total Marks: $totalMarks',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),
        // Overall % and Grade
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoCard('Overall %', overallPercentage),
            _buildInfoCard('Overall Grade', overallGrade),
          ],
        ),
      ],
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0x540C46C4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              'Subject',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Mark',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Grade',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0x540C46C4),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
