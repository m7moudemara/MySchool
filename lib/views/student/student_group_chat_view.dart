import 'package:MySchool/views/student/student_chat_view.dart';
import 'package:flutter/material.dart';

class StudentGroupChatView extends StatefulWidget {
  static final String id = "/StudentGroupChatView";

  const StudentGroupChatView({super.key});

  @override
  State<StudentGroupChatView> createState() => _StudentGroupChatViewState();
}

class _StudentGroupChatViewState extends State<StudentGroupChatView> {
  final List<Map<String, String>> contacts = [
    {
      'groupName': 'Mathematics VII B',
      'lastMessage': 'Abdul Khaidar : Okay, Mrs. Hannah',
      'time': '12.00',
      "image": "assets/chat1.png",
    },
    {
      'groupName': 'English VII B',
      'lastMessage': 'Abdul : Okay Sir',
      'time': '12.00',
      "image": "assets/chat2.png",
    },
    {
      'groupName': 'Biology VII B',
      'lastMessage': 'Jeniffer : Okay Sir',
      'time': '12.00',
      "image": "assets/chat3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Group',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Maison Neue',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 232,
              height: 38,
              decoration: ShapeDecoration(
                color: const Color(0x38979797),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 5,
                    offset: Offset(0, 20),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Searching',
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers:
                  contacts
                      .map(
                        (e) => SliverToBoxAdapter(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset("${e["image"]}"),
                              ),
                              title: Text(e['groupName']!),
                              subtitle: Text(e['lastMessage']!),
                              trailing: Text(e['time']!),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentChatView(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
