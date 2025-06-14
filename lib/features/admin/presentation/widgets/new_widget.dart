import 'package:MySchool/core/utils/utils.dart';
import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  final RichText title;
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
      margin: EdgeInsets.zero,
padding: EdgeInsets.all(12),
      height: ResponsiveUtils.getResponsiveHeight(context, 0.2),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Colors.black.withAlpha(46)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(child: title),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onEdit, icon: Icon(Icons.edit)),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 10, color: Colors.black87),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
