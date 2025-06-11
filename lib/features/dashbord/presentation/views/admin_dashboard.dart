import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
    static String id = '/AdminDashBoard';

  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Admin')));
  }
}
