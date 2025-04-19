import 'package:MySchool/features/school/presentation/views/teacher/classes_details.dart';
import 'package:flutter/material.dart';

class TeacherClassesView extends StatefulWidget {
  static final String id = "/TeacherClassesView";

  const TeacherClassesView({super.key});

  @override
  State<TeacherClassesView> createState() => _TeacherClassesViewState();
}

class _TeacherClassesViewState extends State<TeacherClassesView> {
  int _currentView = 0; // 0 for grid view, 1 for list view
  int _currentClassIndex = 0; // 0 for all, 1-4 for classes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Classes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _currentView == 0 ? _buildGridView() : _buildListView(),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final item = classes[index];
        return _buildAcademicsItem(context, item, index + 1);
      },
    );
  }

  Widget _buildListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Search Bar
          _buildSearchBar(context),
          const SizedBox(height: 24),
          
          // Class Filter Tabs with horizontal scrolling
          _buildClassFilterTabs(),
          const SizedBox(height: 16),
          
          // Students List based on selected tab
          Expanded(
            child: _buildStudentsList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicsItem(BuildContext context, Classes item, int classIndex) {
    return Column(
      children: [
        InkWell(
          onTap: () {
        setState(() {
          _currentView = 1;
          _currentClassIndex = classIndex;
        });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: const Color(0xffE9F9F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Image.asset(item.iconPath, height: 60, width: 60),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0x51A7A7A7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF868686)),
            SizedBox(width: 14),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Color(0xFF868686),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassFilterTabs() {
    final tabs = ['All Students', 'Class 1', 'Class 2', 'Class 3', 'Class 4'];
    
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 8),
          ...List.generate(tabs.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentClassIndex = index;
                  });
                },
                child: _buildFilterTab(tabs[index], isActive: _currentClassIndex == index),
              ),
            );
          }),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String text, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: isActive ? const Color(0xFF0C46C4) : Colors.transparent,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? const Color(0xFF0C46C4) : const Color(0xFF868686),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStudentsList(BuildContext context) {
    // Sample data - in a real app, you would fetch this based on the selected class
    final allStudents = [
      {'name': 'Mohamed Ashraf', 'class': 'Class 1'},
      {'name': 'Ahmed Ali', 'class': 'Class 2'},
      {'name': 'Sara Mohamed', 'class': 'Class 3'},
      {'name': 'Youssef Hassan', 'class': 'Class 4'},
      {'name': 'Fatima Mahmoud', 'class': 'Class 1'},
      {'name': 'Omar Khaled', 'class': 'Class 2'},
      {'name': 'Lina Samir', 'class': 'Class 3'},
    ];

    // Filter students based on selected tab
    List<Map<String, String>> displayedStudents = [];
    if (_currentClassIndex == 0) {
      // All Students
      displayedStudents = allStudents;
    } else {
      // Specific class (1-4)
      displayedStudents = allStudents.where((student) {
        return student['class'] == 'Class $_currentClassIndex';
      }).toList();
    }

    return ListView.separated(
      itemCount: displayedStudents.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildStudentCard(
          context,
          displayedStudents[index]['name']!,
          displayedStudents[index]['class']!,
        );
      },
    );
  }

  Widget _buildStudentCard(BuildContext context, String name, String className) {
    return InkWell(
      onTap: (){
         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassesinfoView(
            studentName: name,
            studentClass: className,
          )));
      },
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 89),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Student Avatar
              Container(
                width: 48,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: NetworkImage("https://placehold.co/48x54"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              
              // Student Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      className,
                      style: const TextStyle(
                        color: Color(0xFF868686),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Classes> classes = [
  Classes(
    title: 'Class 1',
    iconPath: 'assets/classes.png',
    routeName: '',
  ),
  Classes(
    title: 'Class 2',
    iconPath: 'assets/classes.png',
    routeName: '',
  ),
  Classes(
    title: 'Class 3',
    iconPath: 'assets/classes.png',
    routeName: '',
  ),
  Classes(
    title: 'Class 4',
    iconPath: 'assets/classes.png',
    routeName: '',
  ),
];

class Classes {
  final String title;
  final String iconPath;
  final String routeName;

  Classes({
    required this.title,
    required this.iconPath,
    required this.routeName,
  });
}