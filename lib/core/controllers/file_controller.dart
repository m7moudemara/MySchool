import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileController {
  Future<void> downloadFileUsingHttp(String url, String fileName) async {
    // Request permission (Android)
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      print("Permission denied");
      return;
    }

    try {
      // Make HTTP request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get path to save
        final dir = await getExternalStorageDirectory();
        final filePath = "${dir!.path}/$fileName";

        // Save file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await OpenFile.open(filePath);
        print("File downloaded to: $filePath");
      } else {
        print("Failed to download file: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
