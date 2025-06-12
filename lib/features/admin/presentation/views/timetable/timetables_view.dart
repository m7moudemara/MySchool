import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';
import 'package:MySchool/features/admin/presentation/widgets/add_widget.dart';
import 'package:flutter/material.dart';


class TimetablesView extends StatefulWidget {
  const TimetablesView({super.key});
  static const String id = "/TimetablesView";

  @override
  State<TimetablesView> createState() => _TimetablesViewState();
}

class _TimetablesViewState extends State<TimetablesView> {
  final List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Timetables"),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: AddWidget(title: "Add Timetable",width: ResponsiveUtils.getResponsiveWidth(context,0.5),)),
          SliverFillRemaining(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveUtils.getGridColumnCount(context),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: ResponsiveUtils.getResponsiveAspectRatio(context),
              ),
              itemBuilder: (context, index) {
                return items[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
