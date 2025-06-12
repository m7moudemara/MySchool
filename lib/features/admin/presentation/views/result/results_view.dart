import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});
  static const String id = "/ResultsView";

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  void _publishAll() {
    // TODO 
  }

  void _unpublishAll() {
  // TODO 
  }

  void _deleteAll() {
    // TODO 
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
