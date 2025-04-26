
import 'package:MySchool/core/constants.dart';
import 'package:MySchool/features/grades/data/models/subject_model.dart';
import 'package:flutter/material.dart';

class SubjectRowWidget extends StatelessWidget {
  final Subject subject;

  const SubjectRowWidget({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              subject.name,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.scoreBackground.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${subject.score}',
                style: const TextStyle(
                  color: AppColors.scoreText,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.gradeBackground.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                subject.grade,
                style: const TextStyle(
                  color: AppColors.gradeText,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}