import 'package:json_annotation/json_annotation.dart';

import '../model/user_model.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "token")
  final String? accessToken;
  @JsonKey(name: "user")
  final UserModel? user;

  AuthResponse({required this.accessToken, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
