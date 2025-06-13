import 'dart:ui';

import 'package:MySchool/core/constants.dart';

String getGrade(int score, int maxScore) {
  // const int maxScore = 100;
  int difference = maxScore - score;

  if (difference <= 10) {
    return "A";
  } else if (difference <= 20) {
    return "B";
  } else if (difference <= 30) {
    return "C";
  } else if (difference <= 40) {
    return "D";
  } else {
    return "F";
  }
}
Color getGradeColor(String grade) {
  switch (grade) {
    case 'A':
      return AppColors.gradeA;
    case 'B':
      return AppColors.gradeB;
    case 'C':
      return AppColors.gradeC;
    case 'D':
      return AppColors.gradeD;
    case 'F':
      return AppColors.gradeF;
    default:
      return AppColors.textSecondary;
  }
}
