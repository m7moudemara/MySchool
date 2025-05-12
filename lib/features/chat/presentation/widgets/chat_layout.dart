import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/chat/data/models/chat_contact.dart';
import 'package:MySchool/features/chat/data/models/chat_message.dart';
import 'package:MySchool/features/chat/presentation/views/chat_view.dart';
import 'package:flutter/material.dart';

class ChatLayout extends StatefulWidget {
  final String title;
  final List<String> tabs;
  final List<ChatMessage> Function() getMessages;
  final List<ChatContact> Function() getContacts;
  final void Function(BuildContext context, ChatContact contact) onChatTap;

  const ChatLayout({
    super.key,
    required this.title,
    required this.tabs,
    required this.getMessages,
    required this.getContacts,
    required this.onChatTap,
  });

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  late final user = getIt<UserCubit>().state;
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final messages = widget.getMessages();
    final contacts = widget.getContacts();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE8E8E8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search, color: Colors.black),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Maison Neue',
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                user?.imageUrl ?? 'assets/Mini Avatar.png',
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.tabs.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      onPressed: () => setState(() => _selectedTab = index),
                      child: Text(
                        widget.tabs[index],
                        style: TextStyle(
                          color:
                              _selectedTab == index
                                  ? const Color(0xFF0C46C4)
                                  : Colors.black,
                          fontSize: 18,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child:
                  _selectedTab == 0
                      ? _buildMessagesContent(messages)
                      : _buildContactsContent(contacts),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesContent(List<ChatMessage> messages) {
    if (messages.isEmpty) {
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
                'No chat in your inbox yet.\n Start chatting with your Teachers',
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
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(message.image),
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
            Navigator.pushNamed(context, ChatView.id);
          },
        );
      },
    );
  }

  Widget _buildContactsContent(List<ChatContact> contacts) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(contact.image),
            radius: 22,
          ),
          title: Text(
            contact.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(contact.subtitle),
          trailing: Text(
            contact.status,
            style: TextStyle(
              color:
                  contact.status == 'Online' ? Colors.green : Colors.grey[600],
              fontSize: 12,
            ),
          ),
          onTap: () => widget.onChatTap(context, contact),
        );
      },
    );
  }
}
