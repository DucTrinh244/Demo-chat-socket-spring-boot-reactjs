import 'dart:convert';

// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

// import 'package:stomp_dart_client/stomp_frame.dart';

import '../model/message.dart';

class SocketService {
  late StompClient _stompClient;
  final String roomId;
  Function(Message)? onNewMessage;

  SocketService({required this.roomId, this.onNewMessage}) {
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.2.2:8080/chat',
        onConnect: _onConnect,
        onWebSocketError: (dynamic error) => print(error),
      ),
    );
    _stompClient.activate();
  }

  void _onConnect(StompFrame frame) {
    _stompClient.subscribe(
      destination: "/topic/room/$roomId",
      callback: (frame) {
        if (frame.body != null) {
          Message message = Message.fromJson(jsonDecode(frame.body!));
          if (onNewMessage != null) {
            onNewMessage!(message);
          }
        }
      },
    );
  }

  void sendMessage(Message message) {
    _stompClient.send(
      destination: "/app/sendMessage/$roomId",
      body: jsonEncode(message.toJson()),
    );
  }

  void disconnect() {
    _stompClient.deactivate();
  }
}
