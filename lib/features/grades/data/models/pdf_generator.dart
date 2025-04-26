import 'dart:io';
import 'package:MySchool/features/grades/data/models/subject_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

Future<void> generateGradesPdf(List<Subject> subjects) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Student: Mohamed Kamil', style: pw.TextStyle(fontSize: 18)),
          pw.SizedBox(height: 10),
          pw.Text('Grades Summary:', style: pw.TextStyle(fontSize: 16)),
          pw.SizedBox(height: 10),
          ...subjects.map((s) => pw.Text(
              '${s.name}: ${s.score} - ${s.grade}',
              style: const pw.TextStyle(fontSize: 14),
          )),
        ],
      ),
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/grades.pdf');
  await file.writeAsBytes(await pdf.save());
}
