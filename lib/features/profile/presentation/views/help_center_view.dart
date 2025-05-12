import 'package:flutter/material.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});
  static const String id = '/HelpCenterView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help Center",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF225FFF),
            fontSize: 24,
            fontFamily: 'League Spartan',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all( 18.0),
              child: Text('  Contact',style: TextStyle(
color: Colors.black.withValues(alpha: 153),
fontSize: 16.35,
fontFamily: 'Poppins',
fontWeight: FontWeight.w600,
height: 1.20,
),),
            ),
            _buildContactItem(
              image: 'assets/wtsUp.png',
              title: "WhatsApp",
              value: '+201234567890',
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              image: 'assets/email.png',
              title: "Email",
              value: 'support@myschool.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required String image,
    required String title,
    required String value,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Image.asset(image),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),

      trailing: Text(value),
    );
  }
}
