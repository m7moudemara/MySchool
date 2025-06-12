import 'package:MySchool/features/school/presentation/views/teacher/classes_info_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/class_model.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherClassesView extends StatefulWidget {
  static final String id = "/TeacherClassesView";

  const TeacherClassesView({super.key});

  @override
  State<TeacherClassesView> createState() => _TeacherClassesViewState();
}

class _TeacherClassesViewState extends State<TeacherClassesView> {
  int _currentClassIndex = 0;
  String selectedClass = 'All Students';
  String searchText = '';

  List<ClassStudentModel> studentsx = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassesCubit>(context).getClasses();
  }

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
      body: BlocConsumer<ClassesCubit, ClassesState>(
        listener: (context, state) {
          if (state is ClassesLoaded) {
            setState(() {
              studentsx = state.classes;
            });
          }
        },
        builder: (context, state) {
          if (state is ClassesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ClassesLoaded) {
            return _buildListView(studentsx);
          } else {
            return Center(child: Text('There is Error'));
          }
        },
      ),
    );
  }

  getList() {
    return studentsx
        .where(
          (element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
  }

  Widget _buildListView(List<ClassStudentModel> classes) {
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
            child:
                searchText == ''
                    ? _buildStudentsList(context, classes)
                    : _buildStudentsList(context, getList()),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0x51A7A7A7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF868686)),
            SizedBox(width: 14),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
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
    final tabs = ['All Students'];
    for (var element in studentsx) {
      if (tabs.contains(element.className) == false) {
        tabs.add(element.className);
      }
    }
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
                    selectedClass = tabs[index];
                  });
                },
                child: _buildFilterTab(
                  tabs[index],
                  isActive: _currentClassIndex == index,
                ),
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

  Widget _buildStudentsList(
    BuildContext context,
    List<ClassStudentModel> classes,
  ) {
    List<ClassStudentModel> displayedStudents = [];
    if (_currentClassIndex == 0) {
      displayedStudents = classes;
    } else {
      displayedStudents =
          classes.where((student) {
            return student.className == selectedClass;
          }).toList();
      // displayedStudents =
      //     allStudents.where((student) {
      //       return student['class'] == 'Class $_currentClassIndex';
      //     }).toList();
    }

    return ListView.separated(
      itemCount: displayedStudents.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildStudentCard(
          context,
          displayedStudents[index].name,
          displayedStudents[index].className,
          displayedStudents[index].id,
        );
      },
    );
  }

  Widget _buildStudentCard(
    BuildContext context,
    String name,
    String className,
    int studentId,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ClassesinfoView(
                  studentName: name,
                  studentClass: className,
                  studentId: studentId,
                ),
          ),
        );
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
                    image: AssetImage('assets/profile.png'),
                    // image: NetworkImage("https://placehold.co/48x54"),
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
