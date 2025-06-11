// import 'package:signalr_client/signalr_client.dart';
import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/main.dart';
import 'package:signalr_core/signalr_core.dart';

// class SignalRService {
//   HubConnection? hubConnection;

//   Future<void> connect() async {
//     try {
//       final serverUrl = '$baseUrl/api/chatHub'; // Replace with your actual URL
//       // final serverUrl = 'http://<your-server>/chatHub'; // Replace with your actual URL

//       // Creating a new HubConnection
//       hubConnection =
//           HubConnectionBuilder()
//               .withUrl(
//                 serverUrl,
//                 HttpConnectionOptions(
//                   customHeaders: {
//                     'Authorization':
//                         'Bearer ${await sharedPrefController.getToken()}', // Add token to headers
//                   },
//                 ),
//               )
//               .build();

//       // Start the connection
//       await hubConnection!.start();

//       // Listen to messages or events from the server
//       hubConnection!.on('ReceiveMessage', _onReceiveMessage);

//       print('Connected to SignalR Hub');
//     } catch (e) {
//       print('Error connecting to SignalR Hub: $e');
//     }
//   }

//   // Method to handle incoming messages
//   Future<void> _onReceiveMessage(List<Object?>? args) async {
//     if (args != null && args.isNotEmpty) {
//       String message = args[0].toString();
//       print('Received message: $message');
//     }
//   }

//   // Method to send a message to the server
//   Future<void> sendMessage(String message) async {
//     if (hubConnection != null) {
//       await hubConnection!.invoke('SendMessage', args: [message]);
//       print('Sent message: $message');
//     }
//   }

//   // Disconnect the connection
//   Future<void> disconnect() async {
//     if (hubConnection != null) {
//       await hubConnection!.stop();
//       print('Disconnected from SignalR Hub');
//     }
//   }
// }

class SignalRService {
  HubConnection? _hubConnection;

  // Replace this with your actual token

  // Connect to the SignalR server with the authorization token
  Future<void> connect() async {
    try {
      //   final hubConnection =
      // HubConnectionBuilder()
      //     .withUrl(
      //       'http://my-shcool.runasp.net/api/chathub',
      //       HttpConnectionOptions(
      //         accessTokenFactory: () async => sharedPrefController.getToken(),
      //         transport: HttpTransportType.longPolling,
      //       ),
      //     )
      //     .build();
      // final url = 'my-shcool.runasp.net/api/chathub'; // Your SignalR Hub URL
      _hubConnection =
          HubConnectionBuilder()
              .withUrl(
                'http://my-shcool.runasp.net/api/chathub',
                HttpConnectionOptions(
                  accessTokenFactory:
                      () async => sharedPrefController.getToken(),
                  transport: HttpTransportType.webSockets,
                  logging: (level, message) => print('xxxxxx: $message'),
                ),
              )
              .withAutomaticReconnect()
              .build();

      // Listen for connection state changes
      _hubConnection!.onclose((error) {
        print('Connection closed with error: $error');
      });

      // Start the connection
      await _hubConnection!.start();
      print('Connected to SignalR Hub with authorization token');

      // Listen for 'ReceiveMessage' events from the server
      _hubConnection!.on('ReceiveMessage', _onReceiveMessage);
    } catch (e) {
      print('Error connecting to SignalR Hub: $e');
    }
  }

  // Handle the incoming message
  Future<void> _onReceiveMessage(List<Object?>? args) async {
    if (args != null && args.isNotEmpty) {
      print(args);
      // String message = args[0].toString();
      // print('Received message: $message');
    }
  }

  // Send a message to the SignalR server
  Future<void> sendMessage(String message) async {
    if (_hubConnection != null &&
        _hubConnection!.state == HubConnectionState.connected) {
      print('Sent message: $message');
      // await _hubConnection!.invoke('SendMessage', args: ['10', 'vvvvvvvvvv']);
      await _hubConnection!.invoke('SendMessage', args: [10, message]);
      print('Sent message: $message');
    } else {
      print('Not connected to SignalR Hub');
    }
  }

  // Disconnect from the SignalR server
  Future<void> disconnect() async {
    if (_hubConnection != null &&
        _hubConnection!.state == HubConnectionState.connected) {
      await _hubConnection!.stop();
      print('Disconnected from SignalR Hub');
    } else {
      print('Cannot disconnect: The connection is not in a connected state');
    }
  }
}
