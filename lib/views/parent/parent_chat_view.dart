import 'package:MySchool/widgets/comming_soon.dart';
import 'package:flutter/material.dart';


class ParentChatView extends StatelessWidget {
  const ParentChatView({super.key});
  static const String id = "/ParentChatView";

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(title: "Parent Chat");
  }
}
