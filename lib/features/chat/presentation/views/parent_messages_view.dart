import 'package:MySchool/features/chat/data/models/chat_contact.dart';
import 'package:MySchool/features/chat/data/models/chat_message.dart';
import 'package:MySchool/features/chat/presentation/views/chat_view.dart';
import 'package:MySchool/features/chat/presentation/widgets/chat_layout.dart';
import 'package:flutter/material.dart';

class ParentMessagesView extends StatelessWidget {
  static const String id = '/ParentMessagesView';

  const ParentMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatLayout(
      title: 'School Chat',
      tabs: ['Messages', 'People'],
      getMessages: () => [
        ChatMessage(
          senderName: 'Mr. Ahmed (Math Teacher)',
          text: 'Your son Ali has improved significantly in algebra this term',
          image: '',
          timestamp: 'Today, 9:30 AM',
        ),
        ChatMessage(
          senderName: 'School Administration',
          text: 'Reminder: Parent-teacher meetings next Wednesday',
          image: '',
          timestamp: 'Yesterday, 2:15 PM',
        ),
        ChatMessage(
          senderName: 'Miss Salma (Science Teacher)',
          text: 'Please sign the science project permission form',
          image: '',
          timestamp: 'Monday, 11:45 AM',
        ),
        ChatMessage(
          senderName: 'Bus Coordinator',
          text: 'Bus route #5 will be delayed by 15 minutes tomorrow',
          image: '',
          timestamp: 'Last Friday, 4:20 PM',
        ),
      ],
      getContacts: () => [
        ChatContact(
          name: 'Mr. Ahmed',
          image: 'https://randomuser.me/api/portraits/men/11.jpg',
          subtitle: 'Math Teacher - Grade 5',
          status: 'Online',
        ),
        ChatContact(
          name: 'Miss Salma',
          image: 'https://randomuser.me/api/portraits/women/21.jpg',
          subtitle: 'Science Teacher - Grade 5',
          status: 'Last seen 1h ago',
        ),
        ChatContact(
          name: 'Principal Smith',
          image: 'https://randomuser.me/api/portraits/men/50.jpg',
          subtitle: 'School Principal',
          status: 'Available',
        ),
        ChatContact(
          name: 'Nurse Sarah',
          image: 'https://randomuser.me/api/portraits/women/30.jpg',
          subtitle: 'School Clinic',
          status: 'Last seen today at 1 PM',
        ),
        ChatContact(
          name: 'Transport Department',
          image: 'https://randomuser.me/api/portraits/men/60.jpg',
          subtitle: 'Bus Services',
          status: 'Office hours: 7AM-3PM',
        ),
      ],
      onChatTap: (context, contact) {
        Navigator.pushNamed(context, ChatView.id);
      },
    );
  }
}