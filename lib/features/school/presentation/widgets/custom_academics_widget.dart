import 'package:MySchool/core/constants.dart';
import 'package:MySchool/features/school/data/config/academics_items_config.dart';
import 'package:MySchool/holder.dart';
import 'package:MySchool/features/school/presentation/views/student/attendance_view.dart';
import 'package:MySchool/features/school/presentation/views/student/homework_view.dart';
import 'package:MySchool/features/school/presentation/views/result_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_classes_view.dart';
import 'package:flutter/material.dart';

import '../../../main_wrapper/domain/entities/user_role.dart';

class RoleBasedAcademicsCompo extends StatelessWidget {
  final UserRole currentUserRole;
  final List<AcademicsItem> items;

  const RoleBasedAcademicsCompo({
    super.key,
    required this.currentUserRole,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) => item.visibleFor == currentUserRole).toList();

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildAcademicsItem(context, item);
      },
    );
  }

  Widget _buildAcademicsItem(BuildContext context, AcademicsItem item) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, item.routeName),
          child: Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: Color(0xffE9F9F5),
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

  
}

