import 'package:flutter/material.dart';
import '../../data/signal_r.dart';

class SignalRPage extends StatefulWidget {
  @override
  _SignalRPageState createState() => _SignalRPageState();
}

class _SignalRPageState extends State<SignalRPage> {
  final SignalRService _signalRService = SignalRService();
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _signalRService.connect();
  }

  @override
  void dispose() {
    super.dispose();
    _signalRService.disconnect();
  }

  // Method to add message to the list and update UI
  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
    });
  }

  // Method to send a message via SignalR
  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      _signalRService.sendMessage(message);
      _messageController.clear(); // Clear the text input field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignalR Flutter Chat')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Display messages from the server
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_messages[index]));
                },
              ),
            ),
            // TextField to enter a message
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Enter a message',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
            ),
            // Button to send the message
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:signalr_core/signalr_core.dart';

// import '../../../../main.dart';

// class SignalRPage extends StatefulWidget {
//   @override
//   _SignalRPageState createState() => _SignalRPageState();
// }

// class _SignalRPageState extends State<SignalRPage> {
//   final hubConnection =
//       HubConnectionBuilder()
//           .withUrl(
//             'http://my-shcool.runasp.net/api/chathub',
//             HttpConnectionOptions(
//               accessTokenFactory: () async => sharedPrefController.getToken(),
//               transport: HttpTransportType.webSockets,
//               logging: (level, message) => print('xxxxxx: $message'),
//             ),
//           )
//           .withAutomaticReconnect()
//           .build();
//   // final hubConnection =
//   //     HubConnectionBuilder()
//   //         .withUrl(
//   //           'my-shcool.runasp.net/api/chathub',
//   //           HttpConnectionOptions(
//   //             customHeaders: {
//   //               'Content-Type': 'application/json',
//   //               'Accept': 'application/json',
//   //               'Authorization':
//   //                   'Bearer ${sharedPrefController.getToken()}', // Add token to headers
//   //             },
//   //           ),
//   //         )
//   //         .build();

//   TextEditingController messageController = TextEditingController();
//   List<String> messages = [];

//   @override
//   void initState() {
//     super.initState();

//     // Connect to the SignalR hub
//     _startHubConnection();

//     // Define an event handler for receiving messages
//     hubConnection.on('ReceiveMessage', _handleReceivedMessage);
//   }

//   void _startHubConnection() async {
//     try {
//       await hubConnection.start();
//       print('SignalR connection started.');
//     } catch (e) {
//       print('Error starting SignalR connection: $e');
//     }
//   }

//   void _handleReceivedMessage(List<Object?>? arguments) {
//     String user =
//         arguments != null && arguments.isNotEmpty
//             ? (arguments[0] ?? '') as String
//             : '';
//     String message =
//         arguments != null && arguments.length > 1
//             ? (arguments[1] ?? '') as String
//             : '';

//     setState(() {
//       messages.add('$user: $message');
//     });
//   }

//   void _sendMessage() {
//     // if (hubConnection.state == HubConnectionState.connected) {
//     //   print('connected');
//     // } else {
//     //   print('not connected');
//     //   _startHubConnection();
//     // }
//     print(messageController.text);
//     String user = 'You'; // Replace with the user's name or identifier
//     String message = messageController.text;

//     // Send the message to the SignalR hub
//     hubConnection.invoke('SendMessage', args: [10, message]);
//     // hubConnection.invoke('SendMessage', args: [user, message]);

//     // Clear the text input field
//     messageController.text = '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Flutter Chat with SignalR')),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(title: Text(messages[index]));
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter your message',
//                       ),
//                     ),
//                   ),
//                   IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Ensure that the SignalR connection is closed when the app is disposed
//     hubConnection.stop();
//     super.dispose();
//   }
// }
