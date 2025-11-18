import 'chat_model.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    List<ChatModel>? chatHistories,
  }): chatHistories = chatHistories ?? [];

  UserModel.fromJson(dynamic json) {
    name = json['username'];
    email = json['email'];
    if (json['chatHistories'] != null) {
      chatHistories = [];
      json['chatHistories'].forEach((v) {
        chatHistories.add(ChatModel.fromJson(v));
      });
    } else {
      chatHistories = [];
    }
  }

  late String name;
  late String email;
  late List<ChatModel> chatHistories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = name;
    map['email'] = email;
    map['chatHistories'] = chatHistories.map((v) => v.toJson()).toList();
    return map;
  }
}
