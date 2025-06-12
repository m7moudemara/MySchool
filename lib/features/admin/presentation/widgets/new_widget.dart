import 'package:MySchool/core/utils/utils.dart';
import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const NewWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onDelete,
    required this.onEdit, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(16),
      height: ResponsiveUtils.getResponsiveHeight(context, 0.2),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            color: Colors.black.withAlpha(46),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(subtitle),
            ],
          ),
        ],
      ),
    );
  }
}
