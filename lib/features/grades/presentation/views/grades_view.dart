import 'package:MySchool/features/grades/data/models/pdf_generator.dart';
import 'package:MySchool/features/grades/presentation/cubits/grade_cubit.dart';
import 'package:MySchool/features/grades/presentation/widgets/grade_circle_widget.dart';
import 'package:MySchool/features/grades/presentation/widgets/subject_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/core/constants.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key});
  static const id = "/GradeView";

  @override
  Widget build(BuildContext context) {
    const double circleSize = 150;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<GradeCubit, GradesState>(
          builder: (context, state) {
            if (state is GradesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GradesError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is GradesLoaded) {
              final subjects = state.grades;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const GradeCircleWidget(size: circleSize),
                    const SizedBox(height: 16),
                    Text(
                      "",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Overall Grade: A',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 24),
                    SubjectListWidget(subjects: subjects),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.download),
                          label: const Text("Download PDF"),
                          onPressed: () async {
                            await generateGradesPdf(subjects);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("PDF downloaded successfully")),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
