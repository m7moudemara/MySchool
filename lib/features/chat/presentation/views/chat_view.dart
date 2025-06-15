import 'dart:convert';
import 'package:MySchool/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../auth/presentation/cubit/user_cubit.dart';
import '../widgets/chat_bubble.dart';

class ChatView extends StatefulWidget {
  final Map messagess;
  static String id = "/ChatView";
  const ChatView({super.key, required this.messagess});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  bool isLoading = false;
  bool isSending = false;

  // List<Map<String, dynamic>> _messages = [];

  late Stream<List<Map<String, dynamic>>> _messagesStream;
  // Fetch messages from the API and update the stream every second
  Stream<List<Map<String, dynamic>>> _messageStream() async* {
    while (true) {
      final url = Uri.parse(
        '$baseUrl/api/messages?conversation_id=${widget.messagess['conversationId']}&PageSize=500',
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        },
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'];
        List<Map<String, dynamic>> messages =
            data
                .map(
                  (message) => {
                    'content': message['content'],
                    'userId': message['user']['id'],
                    'userName': message['user']['name'],
                    'created_at': message['created_at'],
                  },
                )
                .toList();
        yield messages;
      } else {
        yield [];
      }

      await Future.delayed(Duration(milliseconds: 1000)); // Fetch every 1000ms
    }
  }

  @override
  void initState() {
    super.initState();
    _messagesStream = _messageStream();
  }

  //! Send Messages
  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      isSending = true;
      // Add message locally immediately
      // _messages.add({
      //   'id': 'temp_${DateTime.now().millisecondsSinceEpoch}',
      //   'text': text,
      //   'sender': {'id': 'current_user', 'name': 'You'},
      //   'timestamp': DateTime.now().toIso8601String(),
      // });
      _messageController.clear();
    });

    try {
      final url = Uri.parse('$baseUrl/api/messages');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        },
        body: jsonEncode({
          "conversation_id": widget.messagess['conversationId'],
          "content": text,
        }),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('error');
      }
    } catch (e) {
      setState(() {
        // _messages.removeWhere((m) => m['id'].toString().startsWith('temp_'));
      });
    } finally {
      setState(() => isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ana = context.read<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.messagess['name'],
              style: TextStyle(color: Colors.black),
            ),
            Text(
              widget.messagess['userRole'],
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : StreamBuilder<List<Map<String, dynamic>>>(
                        stream: _messagesStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Map<String, dynamic>> messagesx =
                                snapshot.data!;
                            return ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: messagesx.length,
                              itemBuilder: (context, index) {
                                return ChatBubble(
                                  text: messagesx[index]['content'],
                                  isMe: messagesx[index]['userId'] == ana!.id,
                                  time: messagesx[index]['created_at'],
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text('${snapshot.error}'));
                          } else {
                            return Center(
                              child: Image.asset('assets/loading.gif'),
                            );
                          }
                        },
                      ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
              child: Row(
                children: [
                  Icon(Icons.attachment),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Write your message",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: TextButton(
                            onPressed: _sendMessage,
                            child: Icon(Icons.send_outlined),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: const Color(0xF9414141),
                          fontSize: 13,
                          fontFamily: 'Maison Neue',
                          fontWeight: FontWeight.w700,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.only(left: 31),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt_rounded),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.mic_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
