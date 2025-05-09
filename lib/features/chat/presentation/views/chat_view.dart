import 'package:MySchool/core/widgets/custom_snack_bar.dart';
import 'package:MySchool/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static String id = "/ChatView";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
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
  //! Dio Request
  void _setupDio() {
    _dio.options.baseUrl =
        'https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }
  //! Get All Messages
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
      CustomSnackBar.show(context,e.message.toString() , type: SnackBarType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }
  //! Send Messages
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
      CustomSnackBar.show(context,e.message.toString() , type: SnackBarType.error);
      setState(() {
        _messages.removeWhere((m) => m['id'].toString().startsWith('temp_'));
      });
    } finally {
      setState(() => _isSending = false);
    }
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
