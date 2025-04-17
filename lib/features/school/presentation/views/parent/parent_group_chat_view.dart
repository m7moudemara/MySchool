import 'package:MySchool/features/school/presentation/widgets/comming_soon.dart';
import 'package:flutter/material.dart';

class ParentGroupChatView extends StatelessWidget {
  const ParentGroupChatView({super.key});
  static const String id = "/ParentGroupChatView";

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(title: "Parent Group Chat");
  }
}
