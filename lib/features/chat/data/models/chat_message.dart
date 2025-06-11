class ChatMessage {
  final int id;
  final String senderName;
  final int senderId;
  final String text;
  final String image;
  final String timestamp;
  final bool unread;
  final String userRole;

  ChatMessage({
    required this.id,
    required this.senderName,
    required this.senderId,
    required this.text,
    required this.image,
    required this.timestamp,
    this.unread = false,
    required this.userRole
  });
}
