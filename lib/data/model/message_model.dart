class MessageModel {
  MessageModel({
    required this.content,
    required this.role,
    this.timestamp,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    role = json['role'];
    timestamp = json['timestamp'] != null
        ? DateTime.parse(json['timestamp'])
        : DateTime.now();
  }

  late String content;
  late String role;
  DateTime? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['role'] = role;
    map['timestamp'] = timestamp?.toIso8601String();
    return map;
  }
}