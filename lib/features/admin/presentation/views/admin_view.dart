import 'dart:convert';
import 'package:MySchool/core/constants/constants.dart';
import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/school/data/models/admin_model.dart';
import 'package:MySchool/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/compo.dart';
import '../widgets/custom_card.dart';
import 'classes/add_class_view.dart';
import 'fees/add_fees_view.dart';
import 'parent/add_parents_view.dart';
import 'result/add_results_view.dart';
import 'students/add_students_view.dart';
import 'subjects/add_subjects_view.dart';
import 'teacher/add_teachers_view.dart';
import 'timetable/add_timetables_view.dart';
import 'package:http/http.dart' as http;

class AdminView extends StatefulWidget {
  static String id = '/AdminView';
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  // int totalClasses = 0;
  // late int total_students;
  late int total_classes;
  late int total_teachers;
  late int total_subjects;
  late int total_timetables;
  int? total_fees;
  int? total_parents;
  int? total_students;
  @override
  void initState() {
    super.initState();
    getAlls();
    final userDash =
        context.read<DashboardUserCubit>().state as AdminDashboardUser;
    setState(() {
      total_classes = userDash.total_classes;
      total_teachers = userDash.total_teachers;
      total_subjects = userDash.total_subjects;
      total_timetables = userDash.total_timetables;
    });
  }

  getAlls() async {
    Map<String, String> headersx = {
      'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
      'Accept': 'application/json',
    };
    final response = await http.get(
      Uri.parse('$baseUrl/api/fees?PageSize=500'),
      headers: headersx,
    );
    List fees = jsonDecode(response.body)['data'];

    final response1 = await http.get(
      Uri.parse('$baseUrl/api/accounts?PageSize=500&Where%5Brole%5D=Guardian'),
      headers: headersx,
    );
    List parents = jsonDecode(response1.body)['data'];

    final response2 = await http.get(
      Uri.parse('$baseUrl/api/accounts?PageSize=500&Where%5Brole%5D=Student'),
      headers: headersx,
    );
    List students = jsonDecode(response2.body)['data'];
    setState(() {
      total_fees = fees.length;
      total_parents = parents.length;
      total_students = students.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<Compo> items = [
      Compo(
        count: total_classes,
        image: "assets/classesadmin.png",
        title: "Classes",
        
      ),
      Compo(
        count: total_subjects,
        image: "assets/subjectsadmin.png",
        title: "Subjects",
        
      ),
      Compo(
        count: total_teachers,
        image: "assets/teachersadmin.png",
        title: "Teachers",
        
      ),
      Compo(
        count: total_parents ?? 0,
        image: "assets/parentsadmin.png",
        title: "Parents",
        
      ),
      Compo(
        count: total_students ?? 0,
        image: "assets/studentsadmin.png",
        title: "Students",
        
      ),
      Compo(
        count: total_timetables,
        image: "assets/timetablesadmin.png",
        title: "TimeTables",
        
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("MY SCHOOL", style: TextStyle(color: Color(0xff114066))),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          //! Image
          SliverToBoxAdapter(
            child: Center(
              child: Image.asset(
                "assets/admindashboard.png",
                width: screenWidth * 1,
                height: screenHeight * 0.1,
                fit: BoxFit.contain,
              ),
            ),
          ),
          //! Components
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveUtils.getGridColumnCount(context),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.8,
                ),
                itemBuilder:
                    (context, index) => CustomCard(compo: items[index]),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Admin User'),
              accountEmail: Text('admin@school.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image(image: AssetImage('assets/schoolIconadmin.png')),
              ),
              decoration: BoxDecoration(color: Color(0xff292562)),
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text('Classes'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddClassView.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Subjects'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddSubjectView.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Teachers'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddTeachersView.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Parents'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddParentsView.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Students'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddStudentsView.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Time Tables'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddTimeTableView.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Fees'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddFeesView.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Results'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddResultsView.id);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.blue),
              title: Text('Logout'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
