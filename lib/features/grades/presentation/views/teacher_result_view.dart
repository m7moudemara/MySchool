import 'package:flutter/material.dart';

class TeacherResultView extends StatefulWidget {
  const TeacherResultView({super.key});
  static const String id = '/TeacherResultView';

  @override
  State<TeacherResultView> createState() => _TeacherResultViewState();
}

class _TeacherResultViewState extends State<TeacherResultView> {
  String selectedTerm = 'First';
  String selectedSubject = 'Math';

  // Dropdown options
  final List<String> terms = ['First', 'Second'];
  final List<String> subjects = [
    'English',
    'Arabic',
    'Science',
    'Math',
    'History',
  ];

  // Students list and their results
  List<StudentResult> students = [
    StudentResult(name: 'Mohamed Ashraf', grade: 0, total: 100),
    StudentResult(name: 'Ahmed Ali', grade: 0, total: 100),
    StudentResult(name: 'Sara Mohamed', grade: 0, total: 100),
    StudentResult(name: 'Youssef Hassan', grade: 0, total: 100),
    StudentResult(name: 'Fatima Mahmoud', grade: 0, total: 100),
    StudentResult(name: 'Omar Khaled', grade: 0, total: 100),
    StudentResult(name: 'Lina Samir', grade: 0, total: 100),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Result',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            constraints: BoxConstraints(minHeight: screenHeight),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                // Back button

                // Class, term and subject selection row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! Term dropdown
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Term',
                              style: TextStyle(
                                color: Color(0xFFB6C8E2),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.04,
                              ),
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedTerm,
                              items:
                                  terms.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Color(0xFF2F394B),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.04,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedTerm = newValue!;
                                });
                              },
                              underline: Container(),
                            ),
                          ],
                        ),
                      ),

                      //! Subject dropdown
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subject',
                              style: TextStyle(
                                color: Color(0xFFB6C8E2),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.04,
                              ),
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedSubject,
                              items:
                                  subjects.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Color(0xFF2F394B),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.04,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedSubject = newValue!;
                                });
                              },
                              underline: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Students table header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Students',
                          style: TextStyle(
                            color: Color(0xFF2F394B),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.02,
                          ),
                        ),
                        Text(
                          'Grades',
                          style: TextStyle(
                            color: Color(0xFF2F394B),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Students list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      return _buildStudentItem(students[index], index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Save button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0C46C4),
            minimumSize: Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _saveResults,
          child: Text(
            'Save Changes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentItem(StudentResult student, int index) {
    final isEven = index % 2 == 0;
    final textColor =
        student.grade >= 50 ? Color(0xFF0C46C4) : Color(0xFFF76565);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEven ? Color(0xFFFAFAFA) : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              student.name,
              style: TextStyle(
                color: Color(0xFF495D80),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.04,
              ),
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () => _editStudentGrade(student),
            child: Container(
              width: 80,
              child: Text(
                '${student.grade}/${student.total}',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editStudentGrade(StudentResult student) {
    final gradeController = TextEditingController(
      text: student.grade.toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit Grade'),
            content: TextField(
              controller: gradeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xFFDB4545),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.04,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final newGrade =
                          int.tryParse(gradeController.text) ?? student.grade;
                      setState(() {
                        student.grade = newGrade;
                      });

                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xff0C46C4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  void _saveResults() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Save Changes'),
            content: Text(
              'Are you sure you want to save changes for ${students.length} students?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Changes saved successfully')),
                  );
                  // Here you would add code to save to database
                },
                child: Text('Confirm'),
              ),
            ],
          ),
    );
  }
}

class StudentResult {
  String name;
  int grade;
  int total;

  StudentResult({required this.name, required this.grade, required this.total});
}
