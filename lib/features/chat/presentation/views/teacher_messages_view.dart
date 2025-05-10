import 'package:MySchool/features/chat/data/models/chat_contact.dart';
import 'package:MySchool/features/chat/data/models/chat_message.dart';
import 'package:MySchool/features/chat/presentation/views/chat_view.dart';
import 'package:MySchool/features/chat/presentation/widgets/common_chat_layout.dart';
import 'package:flutter/material.dart';

class TeacherMessagesView extends StatelessWidget {
  static const String id = '/TeacherMessagesView';

  const TeacherMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonChatLayout(
      title: 'Chat',
      tabs: ['Messages', 'People'],
      getMessages: () => [
        ChatMessage(
          senderName: 'Mohammed Ali',
          text: 'Sir, I have a question about problem #5 in the homework',
          image: '',
          timestamp: '11:45 AM',
        ),
        ChatMessage(
          senderName: 'Sarah Ahmed',
          text: 'Thank you for the extra explanation today!',
          image: '',
          timestamp: 'Yesterday',
        ),
        ChatMessage(
          senderName: 'Principal Office',
          text: 'Reminder: Faculty meeting tomorrow at 10 AM',
          image: '',
          timestamp: 'Monday',
        ),
        ChatMessage(
          senderName: 'Ahmed Hassan',
          text: 'Can I get an extension for the project?',
          image: '',
          timestamp: 'Last week',
        ),
      ],
      getContacts: () => [
        ChatContact(
          name: 'Mohammed Ali',
          image: 'https://randomuser.me/api/portraits/men/22.jpg',
          subtitle: 'Grade 10 - Section A',
          status: 'Online',
        ),
        ChatContact(
          name: 'Sarah Ahmed',
          image: 'https://randomuser.me/api/portraits/women/33.jpg',
          subtitle: 'Grade 9 - Section B',
          status: 'Last seen 30m ago',
        ),
        ChatContact(
          name: 'Principal Office',
          image: 'https://randomuser.me/api/portraits/men/40.jpg',
          subtitle: 'Administration',
          status: 'Last seen today at 2 PM',
        ),
        ChatContact(
          name: 'Mr. Khalid',
          image: 'https://randomuser.me/api/portraits/men/55.jpg',
          subtitle: 'English Department',
          status: 'Online',
        ),
        ChatContact(
          name: 'Ms. Fatima',
          image: 'https://randomuser.me/api/portraits/women/44.jpg',
          subtitle: 'Science Department',
          status: 'In a meeting',
        ),
      ],
      onChatTap: (context, contact) {
        Navigator.pushNamed(context, ChatView.id); 
      },
    );
  }
}