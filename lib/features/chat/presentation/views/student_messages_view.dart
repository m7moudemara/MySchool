import 'dart:convert';

import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/features/chat/data/models/chat_contact.dart';
import 'package:MySchool/features/chat/data/models/chat_message.dart';
import 'package:MySchool/features/chat/presentation/views/chat_view.dart';
import 'package:MySchool/features/chat/presentation/widgets/chat_layout.dart';
import 'package:MySchool/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentMessagesView extends StatefulWidget {
  static const String id = '/StudentMessagesView';

  const StudentMessagesView({super.key});

  @override
  State<StudentMessagesView> createState() => _StudentMessagesViewState();
}

class _StudentMessagesViewState extends State<StudentMessagesView> {
  Future<List<ChatContact>> getPeople() async {
    String? token = await sharedPrefController.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/api/conversations/people'),
      headers: {
        'Authorization': ' Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;
      List<ChatContact> people =
          data.map((person) {
            return ChatContact(
              name: person['user']['name'],
              image: person['user']['image'] ?? '',
              subtitle: person['user']['role'] ?? 'Unknown',
              status: person['user']['status'] ?? 'Offline',
            );
          }).toList();
      // Handle successful response
      print(people);
      // print('People fetched successfully: ${people.length}');
      return people;
    } else {
      // Handle error response
      throw Exception('Failed to load people');
    }
  }

  List<ChatContact> contacts = [];
  Future<void> fetchContacts() async {
    try {
      contacts = await getPeople();
      setState(() {});
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  Future<List<ChatMessage>> getMessages() async {
    String? token = await sharedPrefController.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/api/conversations'),
      headers: {
        'Authorization': ' Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;
      List<ChatMessage> messages =
          data.map((message) {
            return ChatMessage(
              senderName: message['user']['name'] ?? 'Unknown',
              text: message['last_message'] ?? '',
              image: message['image'] ?? '',
              timestamp: message['created_at'] ?? '',
            );
          }).toList();
      // Handle successful response
      print(messages);
      // print('Messages fetched successfully: ${messages.length}');
      return messages;
    } else {
      // Handle error response
      throw Exception('Failed to load messages');
    }
  }

  List<ChatMessage> messages = [];
  Future<void> fetchMessages() async {
    try {
      messages = await getMessages();
      setState(() {});
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchContacts();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return ChatLayout(
      title: 'Chat',
      tabs: ['Messages', 'People'],
      getMessages:() => messages, // Fetch messages from the API
          // () => [
          //   ChatMessage(
          //     senderName: 'Mr. Ahmed',
          //     text: 'Don\'t forget to submit your assignment by tomorrow',
          //     image: '',
          //     timestamp: '10:30 AM',
          //   ),
          //   ChatMessage(
          //     senderName: 'Miss Salma',
          //     text: 'Good job on the last science project!',
          //     image: '',
          //     timestamp: 'Yesterday',
          //   ),
          //   ChatMessage(
          //     senderName: 'Mr. Khalid',
          //     text: 'Reminder: Parent-teacher meeting next week',
          //     image: '',
          //     timestamp: 'Monday',
          //   ),
          //   ChatMessage(
          //     senderName: 'School Admin',
          //     text: 'School will be closed next Friday for maintenance',
          //     image: '',
          //     timestamp: 'Last week',
          //   ),
          // ],
      getContacts: () => contacts, // Fetch contacts from the API
      // () => [
      //   ChatContact(
      //     name: 'Mr. Ahmed',
      //     image: 'https://randomuser.me/api/portraits/men/11.jpg',
      //     subtitle: 'Math Teacher',
      //     status: 'Online',
      //   ),
      //   ChatContact(
      //     name: 'Miss Salma',
      //     image: 'https://randomuser.me/api/portraits/women/21.jpg',
      //     subtitle: 'Science Teacher',
      //     status: 'Last seen 1h ago',
      //   ),
      //   ChatContact(
      //     name: 'Mr. Khalid',
      //     image: 'https://randomuser.me/api/portraits/men/32.jpg',
      //     subtitle: 'English Teacher',
      //     status: 'Last seen yesterday',
      //   ),
      //   ChatContact(
      //     name: 'School Admin',
      //     image: 'https://randomuser.me/api/portraits/women/45.jpg',
      //     subtitle: 'Administration',
      //     status: 'Last seen 2d ago',
      //   ),
      //   ChatContact(
      //     name: 'Ms. Fatima',
      //     image: 'https://randomuser.me/api/portraits/women/28.jpg',
      //     subtitle: 'History Teacher',
      //     status: 'Online',
      //   ),
      // ],
      onChatTap: (context, contact) {
        Navigator.pushNamed(context, ChatView.id);
      },
    );
  }
}
