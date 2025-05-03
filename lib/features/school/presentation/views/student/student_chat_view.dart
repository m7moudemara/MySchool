import 'package:MySchool/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class StudentChatView extends StatefulWidget {
  const StudentChatView({super.key});
  static String id = "/StudentChatView";

  @override
  State<StudentChatView> createState() => _StudentChatViewState();
}

class _StudentChatViewState extends State<StudentChatView> {
  final TextEditingController _messageController = TextEditingController();
  final Dio _dio = Dio();
  bool _isLoading = false;
  bool _isSending = false;

  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _setupDio();
    _fetchMessages();
  }

  void _setupDio() {
    _dio.options.baseUrl =
        'https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<void> _fetchMessages() async {
    setState(() => _isLoading = true);
    try {
      final response = await _dio.get('/messages');
      if (response.statusCode == 200) {
        setState(() {
          _messages = List<Map<String, dynamic>>.from(
            response.data.map(
              (msg) => {
                'id': msg['id'],
                'text': msg['text'],
                'sender': msg['sender'] ?? {'id': 'unknown', 'name': 'Unknown'},
                'timestamp':
                    msg['timestamp'] ?? DateTime.now().toIso8601String(),
              },
            ),
          );
        });
      }
    } on DioException catch (e) {
      _showErrorSnackbar('Failed to load messages: ${e.message}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isSending = true;
      // Add message locally immediately
      _messages.add({
        'id': 'temp_${DateTime.now().millisecondsSinceEpoch}',
        'text': text,
        'sender': {'id': 'current_user', 'name': 'You'},
        'timestamp': DateTime.now().toIso8601String(),
      });
      _messageController.clear();
    });

    try {
      final response = await _dio.post(
        '/messages',
        data: {
          'text': text,
          'sender': {'id': 'current_user', 'name': 'You'},
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 201) {
        setState(() {
          final index = _messages.indexWhere(
            (m) => m['id'].toString().startsWith('temp_'),
          );
          if (index != -1) {
            _messages[index] = {
              'id': response.data['id'],
              'text': response.data['text'],
              'sender': response.data['sender'],
              'timestamp': response.data['timestamp'],
            };
          }
        });
      }
    } on DioException catch (e) {
      _showErrorSnackbar('Failed to send message: ${e.message}');
      setState(() {
        _messages.removeWhere((m) => m['id'].toString().startsWith('temp_'));
      });
    } finally {
      setState(() => _isSending = false);
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: Column(
          children: [
            const Text(
              'name',
              style: TextStyle(color: Colors.black),
            ),
            const Text(
              'Active Now',
              style: TextStyle(color: Colors.black45,fontSize: 12),
            ),
          ],
        ),
        backgroundColor:Colors.white, 
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _fetchMessages,
                child:
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            return ChatBubble(
                              text: message['text'],
                              isMe: message['sender']['id'] == 'current_user',
                              time: message['timestamp'],
                            );
                          },
                        ),
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
                            child: Icon(Icons.send_outlined)
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
                  Icon(Icons.camera_alt_rounded),
                  Icon(Icons.mic_rounded),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String? time;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isMe ? Color(0xff0C46C4) :Color(0xffF2F7FB),
          borderRadius:
              isMe
                  ? const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )
                  : const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Maison Neue',
                fontWeight: FontWeight.w700,
              ),
            ),
            if (time != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _formatTime(time!),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String isoTime) {
    try {
      final dateTime = DateTime.parse(isoTime);
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return isoTime;
    }
  }
}
