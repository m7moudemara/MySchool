import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/grades/presentation/cubits/student/grade_cubit.dart';
import 'package:MySchool/features/grades/presentation/cubits/student/grade_state.dart';
import 'package:MySchool/features/grades/presentation/widgets/result_item.dart';
import 'package:MySchool/features/grades/presentation/widgets/term_list_widget.dart';
import 'package:MySchool/features/grades/presentation/widgets/term_widget.dart';
import 'package:MySchool/features/school/data/models/student_model.dart';
// import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentGradesView extends StatefulWidget {
  final Student student;
  const StudentGradesView({super.key, required this.student});
  static const String id = "/StudentGradesView";

  @override
  State<StudentGradesView> createState() => _StudentGradesViewState();
}

class _StudentGradesViewState extends State<StudentGradesView> {
  String selectedTerm = 'First Term';
  final List<String> terms = ['First Term', 'Second Term'];
  bool isTermListVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<GradeCubit>().loadGrades(selectedTerm, widget.student.id);
  }

  @override
  Widget build(BuildContext context) {
    final studentx = context.read<UserCubit>().state;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Result',
          style: TextStyle(
            color: Colors.black,
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
                TermSelectorWidget(
                  selectedTerm: selectedTerm,
                  isTermListVisible: isTermListVisible,
                  onTap: () {
                    setState(() {
                      isTermListVisible = !isTermListVisible;
                    });
                  },
                ),
                const SizedBox(height: 15),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child:
                      isTermListVisible
                          ? TermsListWidget(
                            terms: terms,
                            selectedTerm: selectedTerm,
                            onTermSelected: (term) {
                              setState(() {
                                selectedTerm = term;
                                isTermListVisible = false;
                              });
                              context.read<GradeCubit>().loadGrades(term, widget.student.id);
                            },
                          )
                          : const SizedBox.shrink(),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<GradeCubit, ResultState>(
              builder: (context, state) {
                if (state is ResultLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ResultLoaded) {
                  final result = state.result;
                  final subjects = result?.subjects ?? [];

                  if (result == null || subjects.isEmpty) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/noResult.png",
                              width: 300,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'No result',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "There were no results for “$selectedTerm” Try again",
                              style: TextStyle(
                                color: const Color(0xFF868686),
                                fontSize: 13.15,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.41,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final mappedSubjects =
                      subjects
                          .map(
                            (s) => {
                              'name': s.name,
                              'mark': "${s.mark}/100",
                              'grade': s.grade,
                            },
                          )
                          .toList();

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: ResultItem(
                      //! from user UserCubit
                      studentName: widget.student.name,
                      className: studentx?.className ?? result.className,
                      imageUrl: studentx?.imageUrl ?? result.imageUrl,
                      //! from StudentResultEntity
                      subjects: mappedSubjects,
                      totalMarks: result.totalMarks,
                      overallPercentage: result.overallPercentage,
                      overallGrade: result.overallGrade,
                    ),
                  );
                } else if (state is ResultError) {
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
