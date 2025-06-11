import 'package:flutter/material.dart';

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
          color: isMe ? Color(0xff0C46C4) : Color(0xffF2F7FB),
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
                color: isMe ? Colors.white : Colors.black,
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
                    color: isMe ? Colors.white : Colors.black,
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
