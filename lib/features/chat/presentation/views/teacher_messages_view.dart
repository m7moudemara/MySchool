import 'dart:async';
import 'dart:convert';

import 'package:MySchool/features/chat/data/models/chat_contact.dart';
import 'package:MySchool/features/chat/data/models/chat_message.dart';
import 'package:MySchool/features/chat/presentation/views/chat_view.dart';
import 'package:MySchool/features/chat/presentation/widgets/chat_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/strings.dart';
import '../../../../main.dart';

class TeacherMessagesView extends StatefulWidget {
  static const String id = '/TeacherMessagesView';

  const TeacherMessagesView({super.key});

  @override
  State<TeacherMessagesView> createState() => _TeacherMessagesViewState();
}

class _TeacherMessagesViewState extends State<TeacherMessagesView> {
  String compareTimeWithNow(String givenTime) {
    // Parse the given time string to DateTime
    DateTime parsedGivenTime = DateTime.parse(givenTime);

    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the difference between now and the given time
    Duration difference = now.difference(parsedGivenTime).abs();

    // Check if the difference is within 20 minutes (1200 seconds)
    if (difference.inMinutes <= 20) {
      return 'Online'; // If the time is within 20 minutes, it's considered online
    } else {
      return 'Offline'; // If the time difference is more than 20 minutes, it's considered offline
    }
  }

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
              id: person['user']['id'] ?? 0,
              name: person['user']['name'],
              image: person['user']['image'] ?? '',
              subtitle: person['user']['role'] ?? 'Unknown',
              status: compareTimeWithNow(person['user']['last_active_time']),
              // status: person['user']['status'] ?? 'Offline',
            );
          }).toList();
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
              id: message['id'],
              senderId: message['user']['id'],
              senderName: message['user']['name'] ?? 'Unknown',
              text:
                  message['last_message'] == null
                      ? ''
                      : message['last_message']['content'],
              image: message['image'] ?? '',
              timestamp:
                  message['last_message'] == null
                      ? ''
                      : message['last_message']['created_at'],
              userRole: message['user']['role'],
            );
          }).toList();
      // Handle successful response
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

  createNewConversation(int contactId) async {
    String? token = await sharedPrefController.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/api/conversations?UserId=$contactId'),
      headers: {
        'Authorization': ' Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Navigator.pushNamed(
        context,
        ChatView.id,
        arguments: {
          'name': data['user']['name'],
          'conversationId': data['id'],
          'userId': data['user']['id'],
          'userRole': data['user']['role'],
        },
      );
    } else {
      throw Exception('error');
    }
  }

  late Timer timer;
  @override
void initState() {
  super.initState();
  fetchContacts();
  fetchMessages();
  timer = Timer.periodic(Duration(seconds: 2), (timer) {
    fetchContacts();
    fetchMessages();
    if (mounted) {
      setState(() {});
    }
  });
}
  @override
void dispose() {
  timer.cancel(); 
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return ChatLayout(
      title: 'Chat',
      tabs: ['Messages', 'People'],
      getMessages: () => messages,
      getContacts: () => contacts,
      onChatTap: (context, contact) {
        createNewConversation(contact.id);
      },
    );
  }
}
