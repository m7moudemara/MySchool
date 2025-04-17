import 'package:MySchool/features/school/presentation/views/student/student_chat_view.dart';
import 'package:flutter/material.dart';

class StudentGroupChatView extends StatefulWidget {
  static final String id = "/StudentGroupChatView";

  const StudentGroupChatView({super.key});

  @override
  State<StudentGroupChatView> createState() => _StudentGroupChatViewState();
}

class _StudentGroupChatViewState extends State<StudentGroupChatView> {
  final TextEditingController _searchController = TextEditingController();

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

  List<Map<String, String>> filteredContacts = [];
  //! To Highlight Text
  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return Text(text);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final startIndex = lowerText.indexOf(lowerQuery);

    if (startIndex == -1) {
      return Text(text);
    }

    final endIndex = startIndex + query.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, startIndex),
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: text.substring(endIndex),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
    _searchController.addListener(_filterContacts);
  }

  void _filterContacts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredContacts =
          contacts.where((contact) {
            String name = contact['groupName']!.toLowerCase();
            return name.contains(query);
          }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                controller: _searchController,
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
                              title: _buildHighlightedText(
                                e['groupName']!,
                                _searchController.text,
                              ),

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
