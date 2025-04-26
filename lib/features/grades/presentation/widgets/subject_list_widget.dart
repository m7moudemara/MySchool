
import 'package:MySchool/core/constants.dart';
import 'package:MySchool/features/grades/data/models/subject_model.dart';
import 'package:MySchool/features/grades/presentation/widgets/subject_row_widget.dart';
import 'package:flutter/material.dart';

class SubjectListWidget extends StatelessWidget {
  final List<Subject> subjects;

  const SubjectListWidget({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Subject",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Score",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Grade",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 24, thickness: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subjects.length,
              separatorBuilder: (context, index) => const Divider(height: 16, thickness: 0.5),
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return SubjectRowWidget(subject: subject);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}