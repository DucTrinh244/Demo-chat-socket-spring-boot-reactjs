class Message {
  final String sender;
  final String content;
  final DateTime timeStamp;

  Message({
    required this.sender,
    required this.content,
    required this.timeStamp,
  });

  // Chuyển từ JSON sang object Message
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      content: json['content'],
      timeStamp: DateTime.parse(json['timeStamp']),
    );
  }

  // Chuyển từ object Message sang JSON
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'content': content,
      'timeStamp': timeStamp.toIso8601String(),
    };
  }
}
