import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/school/presentation/views/student/student_chat_view.dart';
import 'package:flutter/material.dart';

class StudentMessagesView extends StatefulWidget {
  static final String id = "/StudentConversationView";

  const StudentMessagesView({super.key});

  @override
  State<StudentMessagesView> createState() => _StudentMessagesViewState();
}

class _StudentMessagesViewState extends State<StudentMessagesView> {
  int _selectedTab = 0;
  final _messages = [];
  final _teachers = [];
  bool _hasMessages = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            decoration: BoxDecoration(
              color: Color(0xffE8E8E8),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search),
          ),
          title: const Text(
            'Chat',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Maison Neue',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: [
            CircleAvatar(
              child: Image.network(getIt<UserCubit>().state?.imageUrl ?? ''),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const StudentChatView();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButton('Message', 0),
                    const SizedBox(width: 40),
                    _buildTabButton('Teachers', 1),
                  ],
                ),
              ),
              Expanded(
                child:
                    _selectedTab == 0
                        ? _buildMessagesContent()
                        : _buildTeachersContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int tabIndex) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedTab = tabIndex;
        });
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Text(
        text,
        style: TextStyle(
          color:
              _selectedTab == tabIndex ? const Color(0xFF0C46C4) : Colors.black,
          fontSize: 18,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMessagesContent() {
    if (!_hasMessages) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 105,
                height: 102,
                decoration: const ShapeDecoration(
                  color: Color(0x1E868686),
                  shape: OvalBorder(),
                ),
                child: const Icon(Icons.chat, color: Colors.blue, size: 25),
              ),
              const SizedBox(height: 30),
              Text(
                'No chats',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.86),
                  fontSize: 31,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'No chat in your inbox yet.\nStart chatting with your Teachers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF868686),
                  fontSize: 15,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(message.image ?? ''),
            radius: 22,
          ),
          title: Text(
            message.senderName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(message.text),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.timestamp,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              if (message.unread)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentChatView()),
            );
          },
        );
      },
    );
  }

  Widget _buildTeachersContent() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: _teachers.length,
      itemBuilder: (context, index) {
        final teacher = _teachers[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(teacher.image),
            radius: 22,
          ),
          title: Text(
            teacher.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(teacher.subject),
          trailing: Text(
            teacher.lastSeen,
            style: TextStyle(
              color:
                  teacher.lastSeen == 'Online'
                      ? Colors.green
                      : Colors.grey[600],
              fontSize: 12,
            ),
          ),
          onTap: () {},
        );
      },
    );
  }
}
