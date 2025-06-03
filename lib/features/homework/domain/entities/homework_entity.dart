import 'package:file_picker/file_picker.dart';

class HomeworkEntity {
  final String title;
  final String subject;
   final DateTime deadline;
  final PlatformFile? attachmentFile;

  HomeworkEntity({
    required this.title,
    required this.subject,
    required this.deadline,
    this.attachmentFile, 
  });
}