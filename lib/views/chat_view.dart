import 'package:MySchool/constants.dart';
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
  int _currentIndex = 0;
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
        // Update the temporary message with server data
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
      // Remove the temporary message if sending failed
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

  Image _getImage(int index) {
    switch (index) {
      case 0:
        return Image.asset("assets/home.png", height: 30.67, width: 30.24);
      case 1:
        return Image.asset("assets/chat.png", height: 30.67, width: 30.24);
      case 2:
        return Image.asset("assets/people.png", height: 30.67, width: 38.42);
      case 3:
        return Image.asset("assets/person.png", height: 30, width: 30);
      default:
        return Image.asset("assets/home.png", height: 30.67, width: 30.24);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Chat',style: TextStyle(color: Colors.deepOrangeAccent),),
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: Column(
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
            padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 32),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    
                    controller: _messageController,
                    decoration: InputDecoration(
                      
                      
                      hintText: "Type Message",
                      suffixIcon:
                         Padding(
                           padding: const EdgeInsets.only(right: 20.0),
                           child: TextButton(
                                  onPressed: _sendMessage,
                                  child: Text(
                                    'Send',
                                    style: TextStyle(
                                      color: const Color(0xFF041571),
                                      fontSize: 13,
                                      fontFamily: 'Maison Neue',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
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
                      contentPadding: const EdgeInsets.only(
                        left: 31,
                        
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
             
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: const Color(0xff103568),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          items: List.generate(4, (index) {
            return BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 5),
                decoration:
                    _currentIndex == index
                        ? const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF3620C2),
                              width: 2,
                            ),
                          ),
                        )
                        : null,
                child: _getImage(index),
              ),
              label: '',
            );
          }),
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
          color: isMe ? AppColors.kSecondaryColor : AppColors.kDarkColor,
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
