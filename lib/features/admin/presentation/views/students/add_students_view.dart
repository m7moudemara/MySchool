import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/core/widgets/app_bar.dart';

import 'package:flutter/material.dart';

import '../../widgets/add_widget.dart';
import '../../widgets/create_new_widget.dart';
import '../../widgets/new_widget.dart';


class StudentsView extends StatefulWidget {
  const StudentsView({super.key});
  static const String id = "/StudentsView";

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  List<TextEditingController> controllers = [];

  bool showForm = false;
  final List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Students"),
      body: showForm
          ? CreateNewWidget(
              title: "Add Student",
          
              items: [],
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: AddWidget(
                  onTap: () {
                    setState(() {
                      showForm = true;
                    });
                  },
                  title: "Add Student",
                  width: ResponsiveUtils.getResponsiveWidth(context, 0.5),
                )),
                SliverFillRemaining(
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          ResponsiveUtils.getGridColumnCount(context),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio:
                          ResponsiveUtils.getResponsiveAspectRatio(context),
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return NewWidget(
                          title: item.name,
                          subtitle: item.grade,
                          onDelete: () {
                            setState(() {
                              items.removeAt(index);
                            });
                          }, onEdit: () {  },);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
