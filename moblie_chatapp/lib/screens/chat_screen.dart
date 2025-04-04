import 'package:flutter/material.dart';

import '../model/message.dart';
import '../services/socket_service.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;

  ChatScreen({required this.roomId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SocketService socketService;
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    socketService = SocketService(
      roomId: widget.roomId,
      onNewMessage: (message) {
        setState(() {
          messages.add(message);
        });
      },
    );
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      Message message = Message(
        sender: "User",
        content: messageController.text,
        timeStamp: DateTime.now(),
      );
      socketService.sendMessage(message);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Room: ${widget.roomId}")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index].sender),
                  subtitle: Text(messages[index].content),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: "Enter message"),
                  ),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
