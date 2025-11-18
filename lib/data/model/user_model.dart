class UserModel {
  UserModel({
    required this.name,
    required this.email,
  });

  UserModel.fromJson(dynamic json) {
    name = json['username'];
    email = json['email'];
  }

  late String name;
  late String email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = name;
    map['email'] = email;
    return map;
  }
}
