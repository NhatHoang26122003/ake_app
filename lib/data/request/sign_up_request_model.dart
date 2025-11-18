class SignUpRequestModel {
  SignUpRequestModel({
    this.username,
    this.password,
    this.email,
  });

  // SignUpRequestModel copyWith({
  //   String? password,
  //   String? email,
  // }) {
  //   return SignUpRequestModel(
  //     password: password ?? this.password,
  //     email: email ?? this.email,
  //   );
  // }

  SignUpRequestModel.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  String? username;
  String? password;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
