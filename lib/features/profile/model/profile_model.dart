class UserProfile {
  final String fullName;
  final String userName;
  final String email;
  final String password;
  final String phone;
  String? image;

  UserProfile({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
    required this.image
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json['name'],
      userName: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
        image : json['image']
    );
  }
}
