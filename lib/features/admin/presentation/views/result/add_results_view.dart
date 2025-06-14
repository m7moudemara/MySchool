import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddResultsView extends StatefulWidget {
  const AddResultsView({super.key});
  static const String id = "/ResultsView";

  @override
  State<AddResultsView> createState() => _AddResultsViewState();
}

class _AddResultsViewState extends State<AddResultsView> {
  void _publishAll() async {
    final url = Uri.parse('$baseUrl/api/grades/publish');
    try {
      await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All Grades have been published!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void _unpublishAll() async {
    final url = Uri.parse('$baseUrl/api/grades/unpublish');
    try {
      await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All Grades have been unpublished!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void _deleteAll() async {
    final url = Uri.parse('$baseUrl/api/grades/delete-all');
    try {
      await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All Grades have been deleted!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Result"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildButton(
              text: 'Publish All',
              color: Colors.blue,
              onPressed: _publishAll,
            ),
            const SizedBox(height: 16),
            _buildButton(
              text: 'UnPublish All',
              color: Colors.grey,
              onPressed: _unpublishAll,
            ),
            const SizedBox(height: 16),
            _buildButton(
              text: 'Delete All',
              color: Colors.red,
              onPressed: _deleteAll,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildButton({
  required String text,
  required Color color,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
