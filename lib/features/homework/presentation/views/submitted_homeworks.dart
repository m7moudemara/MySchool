import 'package:MySchool/features/homework/presentation/widgets/student_card.dart';
import 'package:flutter/material.dart';

class ViewAttachmentPage extends StatelessWidget {
  const ViewAttachmentPage({super.key});

  final List<Map<String, dynamic>> students = const [
    {
      'name': 'Mohamed Ashraf',
      'number': 'Number 1',
      'image': 'assets/profile.png',
      'submitted': true,
    },
    {
      'name': 'Hager Ashraf',
      'number': 'Number 2',
      'image': 'assets/profile.png',
      'submitted': true,
    },
    {
      'name': 'abdelRahman Ali',
      'number': 'Number 3',
      'image': 'assets/profile.png',
      'submitted': false,
    },
    {
      'name': 'hoor Moman',
      'number': 'Number 4',
      'image': 'assets/profile.png',
      'submitted': false,
    },
    {
      'name': 'Hazem Younes',
      'number': 'Number 5',
      'image': 'assets/profile.png',
      'submitted': true,
    },
    {
      'name': 'Aicha Mohamed',
      'number': 'Number 6',
      'image': 'assets/profile.png',
      'submitted': false,
    },
    {
      'name': 'Arwa Ahmed',
      'number': 'Number 7',
      'image': 'assets/profile.png',
      'submitted': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homework',
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
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C46C4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'View Homework',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.30,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! Total Students
                  Text(
                    'Total Students:${students.length}',
                    style: TextStyle(fontSize: 16),
                  ), 
                  //! Search
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        cursorHeight: 16,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          contentPadding: EdgeInsets.symmetric(vertical: 2),
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              _buildButtons(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return StudentCard(
                      name: student['name'],
                      number: student['number'],
                      imageUrl: student['image'],
                      submitted: student['submitted'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _roundedButton('Missing', const Color(0xFFF2ABFE))),
        Expanded(child: _roundedButton('Submitted', const Color(0xFF0C46C4))),
      ],
    );
  }

  Widget _roundedButton(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(47),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
