import 'package:MySchool/features/chat/data/models/chat_contact.dart';
import 'package:MySchool/features/chat/data/models/chat_message.dart';
import 'package:MySchool/features/chat/presentation/views/chat_view.dart';
import 'package:MySchool/features/chat/presentation/widgets/common_chat_layout.dart';
import 'package:flutter/material.dart';

class StudentMessagesView extends StatelessWidget {
  static const String id = '/StudentMessagesView';

  const StudentMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonChatLayout(
      title: 'Chat',
      tabs: ['Messages', 'People'],
      getMessages:
          () => [
            ChatMessage(
              senderName: 'Mr. Ahmed',
              text: 'Don\'t forget to submit your assignment by tomorrow',
              image: '',
              timestamp: '10:30 AM',
            ),
            ChatMessage(
              senderName: 'Miss Salma',
              text: 'Good job on the last science project!',
              image: '',
              timestamp: 'Yesterday',
            ),
            ChatMessage(
              senderName: 'Mr. Khalid',
              text: 'Reminder: Parent-teacher meeting next week',
              image: '',
              timestamp: 'Monday',
            ),
            ChatMessage(
              senderName: 'School Admin',
              text: 'School will be closed next Friday for maintenance',
              image: '',
              timestamp: 'Last week',
            ),
          ],
      getContacts:
          () => [
            ChatContact(
              name: 'Mr. Ahmed',
              image: 'https://randomuser.me/api/portraits/men/11.jpg',
              subtitle: 'Math Teacher',
              status: 'Online',
            ),
            ChatContact(
              name: 'Miss Salma',
              image: 'https://randomuser.me/api/portraits/women/21.jpg',
              subtitle: 'Science Teacher',
              status: 'Last seen 1h ago',
            ),
            ChatContact(
              name: 'Mr. Khalid',
              image: 'https://randomuser.me/api/portraits/men/32.jpg',
              subtitle: 'English Teacher',
              status: 'Last seen yesterday',
            ),
            ChatContact(
              name: 'School Admin',
              image: 'https://randomuser.me/api/portraits/women/45.jpg',
              subtitle: 'Administration',
              status: 'Last seen 2d ago',
            ),
            ChatContact(
              name: 'Ms. Fatima',
              image: 'https://randomuser.me/api/portraits/women/28.jpg',
              subtitle: 'History Teacher',
              status: 'Online',
            ),
          ],
      onChatTap: (context, contact) {
        Navigator.pushNamed(context, ChatView.id);
      },
    );
  }
}