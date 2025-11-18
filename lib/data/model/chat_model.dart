class ChatModel {
  ChatModel({
    this.id,
    this.title,
  });

  ChatModel.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
  }

  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    return map;
  }
}