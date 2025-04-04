import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JoinCreateChat extends StatefulWidget {
  const JoinCreateChat({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JoinCreateChatState createState() => _JoinCreateChatState();
}

class _JoinCreateChatState extends State<JoinCreateChat> {
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final String apiBaseUrl = "http://localhost:8080/api/v1/rooms";

  Future<void> joinChat() async {
    if (_roomIdController.text.isEmpty || _userNameController.text.isEmpty) {
      _showToast("Invalid Input!!");
      return;
    }

    final response = await http.get(
      Uri.parse("$apiBaseUrl/${_roomIdController.text}"),
    );

    if (response.statusCode == 200) {
      _showToast("Joined Successfully");
      Navigator.pushNamed(
        // ignore: use_build_context_synchronously
        context,
        "/chat",
        arguments: {
          "roomId": _roomIdController.text,
          "userName": _userNameController.text,
        },
      );
    } else {
      _showToast("Room not found");
    }
  }

  Future<void> createRoom() async {
    if (_roomIdController.text.isEmpty || _userNameController.text.isEmpty) {
      _showToast("Invalid Input!!");
      return;
    }

    final response = await http.post(
      Uri.parse(apiBaseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_roomIdController.text),
    );

    if (response.statusCode == 201) {
      _showToast("Room Created Successfully");
      Navigator.pushNamed(
        // ignore: use_build_context_synchronously
        context,
        "/chat",
        arguments: {
          "roomId": _roomIdController.text,
          "userName": _userNameController.text,
        },
      );
    } else {
      _showToast("Room already exists");
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: "Your Name"),
              ),
              TextField(
                controller: _roomIdController,
                decoration: InputDecoration(labelText: "Room ID / New Room ID"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: joinChat, child: Text("Join Room")),
                  ElevatedButton(
                    onPressed: createRoom,
                    child: Text("Create Room"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
