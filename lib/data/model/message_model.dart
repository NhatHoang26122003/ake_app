class MessageModel {
  MessageModel({
    required this.text,
    required this.role,
    this.timestamp,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    role = json['role'];
    timestamp = json['timestamp'] != null
        ? DateTime.parse(json['timestamp'])
        : DateTime.now();
  }

  late String text;
  late String role;
  DateTime? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['role'] = role;
    map['timestamp'] = timestamp?.toIso8601String();
    return map;
  }
}