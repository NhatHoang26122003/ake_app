import 'message_model.dart';

class ChatModel {
  ChatModel({
    this.id,
    this.name,
    List<MessageModel>? messages,
  }) : messages = messages ?? [];

  ChatModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];

    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages.add(MessageModel.fromJson(v));
      });
    } else {
      messages = [];
    }
  }

  int? id;
  String? name;
  late List<MessageModel> messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['messages'] = messages.map((v) => v.toJson()).toList();
    return map;
  }
}