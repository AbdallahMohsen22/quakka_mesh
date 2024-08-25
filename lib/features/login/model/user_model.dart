class UserModel {
  UserModel({
      this.result,});

  UserModel.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
      this.id,
      this.message,
      this.isAuthenticated,
      this.username,
      this.email,
      this.token,
      this.expiresOn,
      this.refreshTokenExpiration,
  });

  Result.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    isAuthenticated = json['isAuthenticated'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
    expiresOn = json['expiresOn'];
    refreshTokenExpiration = json['refreshTokenExpiration'];
    isAdmin = json['isAdmin'];
  }
  String? id;
  String? message;
  bool? isAuthenticated;
  bool? isAdmin;
  String? username;
  String? email;
  String? token;
  String? expiresOn;
  String? refreshTokenExpiration;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['isAuthenticated'] = isAuthenticated;
    map['isAdmin'] = isAdmin;
    map['username'] = username;
    map['email'] = email;
    map['token'] = token;
    map['expiresOn'] = expiresOn;
    map['refreshTokenExpiration'] = refreshTokenExpiration;
    return map;
  }

}