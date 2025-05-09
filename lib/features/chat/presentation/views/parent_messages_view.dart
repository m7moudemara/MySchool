import 'package:MySchool/features/chat/data/models/chat_contact.dart';
import 'package:MySchool/features/chat/presentation/widgets/common_chat_layout.dart';
import 'package:flutter/material.dart';

class ParentMessagesView extends StatelessWidget {
  static const String id = '/ParentMessagesView';

  const ParentMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonChatLayout(
      title: 'Chat',
      tabs: ['Messages', 'People'],
      getMessages: () => [
      
      ],
      getContacts: () => [
        ChatContact(
          name: 'Mr. Ahmed',
          image:
              'https://randomuser.me/api/portraits/men/11.jpg',
          subtitle: 'Math Teacher',
          status: 'Online',
        ),
        ChatContact(
          name: 'Miss Salma',
          image:
              'https://randomuser.me/api/portraits/women/21.jpg',
          subtitle: 'Science Teacher',
          status: 'Last seen 1h ago',
        ),
      ],
      onChatTap: (context, contact) {
        
        Navigator.pushNamed(context, '/StudentChatView');
      },
    );
  }
}
