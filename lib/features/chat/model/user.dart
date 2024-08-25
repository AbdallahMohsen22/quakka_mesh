class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String userName;
  final String email;
  final String dateTime;
  final bool isAdmin;
  final String imageCover;

  User({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.userName,
    required this.email,
    required this.dateTime,
    required this.isAdmin,
    required this.imageCover,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      userName: json['userName'],
      email: json['email'],
      dateTime: json['dateTime'],
      isAdmin: json['isAdmin'],
      imageCover: json['imageCover'],
    );
  }
}