import 'package:MySchool/widgets/comming_soon.dart';
import 'package:flutter/material.dart';


class ParentDashboardView extends StatelessWidget {
  const ParentDashboardView({super.key});
  static const String id = "/ParentDashboardView";

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(title: "Parent Dashboard");
  }
}
