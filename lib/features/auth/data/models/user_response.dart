import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'username')
  String username;
  @JsonKey(name: 'isAuthenticated')
  bool isAuthenticated;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'expiresOn')
  String expiresOn;
  @JsonKey(name: 'refreshTokenExpiration')
  String refreshTokenExpiration;



  UserResponse(
      this.id,
      this.message,
      this.isAuthenticated,
      this.username,
      this.email,
      this.token,
      this.expiresOn,
      this.refreshTokenExpiration,
      );
  factory  UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson()=> _$UserResponseToJson(this);
}
