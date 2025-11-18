// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  accessToken: json['token'] as String?,
  user: json['user'] == null ? null : UserModel.fromJson(json['user']),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'token': instance.accessToken,
      'user': instance.user,
    };
