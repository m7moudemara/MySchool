class Student {
  final String name;
  final String className;
  final String imageUrl;
  final int totalDays;
  final int absentDays;

  Student({
    required this.name,
    required this.className,
    required this.imageUrl,
    required this.totalDays,
    required this.absentDays,
  });

  double get attendancePercentage => ((totalDays - absentDays) / totalDays) * 100;
  double get absencePercentage => (absentDays / totalDays) * 100;
}