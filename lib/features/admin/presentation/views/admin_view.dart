import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
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

class AdminView extends StatefulWidget {
  static String id = '/AdminView';
  AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  // int totalClasses = 0;
  final List<Compo> items = [
    Compo(
      count: 50,
      image: "assets/classesadmin.png",
      title: "Classes",
      route: AddClassView.id,
    ),
    Compo(
      count: 50,
      image: "assets/subjectsadmin.png",
      title: "Subjects",
      route: AddSubjectView.id,
    ),
    Compo(
      count: 50,
      image: "assets/teachersadmin.png",
      title: "Teachers",
      route: AddTeachersView.id,
    ),
    Compo(
      count: 50,
      image: "assets/parentsadmin.png",
      title: "Parents",
      route: AddParentsView.id,
    ),
    Compo(
      count: 50,
      image: "assets/studentsadmin.png",
      title: "Students",
      route: AddStudentsView.id,
    ),
    Compo(
      count: 50,
      image: "assets/timetablesadmin.png",
      title: "TimeTables",
      route: AddTimeTableView.id,
    ),
    Compo(
      count: 0,
      image: "assets/feesadmin.png",
      title: "Fees",
      route: AddFeesView.id,
    ),
    Compo(
      count: 0,
      image: "assets/resultsadmin.png",
      title: "Results",
      route: AddResultsView.id,
    ),
  ];
  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>();
    final userDash = context.read<DashboardUserCubit>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("MY SCHOOL",style : TextStyle(
          color: Color(0xff114066),
        )),
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
