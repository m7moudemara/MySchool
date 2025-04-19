import 'package:flutter/material.dart';

class TimeTableView extends StatelessWidget {
  TimeTableView({super.key});
  static String id = "/TimeTable";
  String? selectedClass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Table"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: DropdownButtonFormField<String>(
                                hint: Text("Select Day"),
                                decoration: const InputDecoration(
        
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  isDense: true,
                                ),
                                items:
                                      ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"].map((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  selectedClass = value;
                                },
                              ),
      ),
                          Expanded(child: Container(
                            color: Colors.amber,
                          ))
        ],
      ),
    );
  }
}