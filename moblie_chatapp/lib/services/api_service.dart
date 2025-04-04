import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/message.dart';
import '../model/room.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8080/api/v1/rooms";

  // 🔹 Tạo phòng chat
  Future<Room?> createRoom(String roomId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(roomId),
    );
    if (response.statusCode == 201) {
      return Room.fromJson(json.decode(response.body));
    }
    return null;
  }

  // 🔹 Tham gia phòng chat
  Future<Room?> joinRoom(String roomId) async {
    final response = await http.get(Uri.parse("$baseUrl/$roomId"));
    if (response.statusCode == 200) {
      return Room.fromJson(json.decode(response.body));
    }
    return null;
  }

  // 🔹 Lấy danh sách tin nhắn
  Future<List<Message>> getMessages(String roomId) async {
    final response = await http.get(Uri.parse("$baseUrl/$roomId/messages"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    }
    return [];
  }
}
