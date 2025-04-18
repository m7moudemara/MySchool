import 'package:flutter/material.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  static String id = '/NotificationsView';

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF161C2B)),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Text(
          "Notification",
          style: TextStyle(
            color: const Color(0xFF161C2B),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 331,
              height: 370,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/notifications.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'No notification, yet!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF161C2B),
                fontSize: 30,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 54.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt dolore magna aliqua',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF6F6F79),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
