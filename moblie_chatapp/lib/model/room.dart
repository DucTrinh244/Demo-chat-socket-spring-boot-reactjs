import 'message.dart';

class Room {
  final String id;
  final String roomId;
  final List<Message> messages;
  final List<String> members;

  Room({
    required this.id,
    required this.roomId,
    required this.messages,
    required this.members,
  });

  // Chuyển từ JSON sang object Room
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomId: json['roomId'],
      messages:
          (json['messages'] as List<dynamic>)
              .map((m) => Message.fromJson(m))
              .toList(),
      members: List<String>.from(json['members']),
    );
  }

  // Chuyển từ object Room sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'messages': messages.map((m) => m.toJson()).toList(),
      'members': members,
    };
  }
}
