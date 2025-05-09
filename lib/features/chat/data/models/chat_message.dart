class ChatMessage {
  final String senderName;
  final String text;
  final String image;
  final String timestamp;
  final bool unread;

  ChatMessage({
    required this.senderName,
    required this.text,
    required this.image,
    required this.timestamp,
    this.unread = false,
  });
}
