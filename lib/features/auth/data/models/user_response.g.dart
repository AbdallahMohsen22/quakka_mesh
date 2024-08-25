// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['id'] as String,
      json['message'] as String,
      json['isAuthenticated'] as bool,
      json['username'] as String,
      json['email'] as String,
      json['token'] as String,
      json['expiresOn'] as String,
      json['refreshTokenExpiration'] as String,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'username': instance.username,
      'isAuthenticated': instance.isAuthenticated,
      'email': instance.email,
      'token': instance.token,
      'expiresOn': instance.expiresOn,
      'refreshTokenExpiration': instance.refreshTokenExpiration,
    };
