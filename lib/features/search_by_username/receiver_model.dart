class ReceiverUser {
  final String id;
  final String userName;
  final String fullName;
  final String imageCover;
  final String email;

  ReceiverUser({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.imageCover,
    required this.email,
  });

  factory ReceiverUser.fromJson(Map<String, dynamic> json) {
    return ReceiverUser(
      id: json['id'],
      userName: json['userName'],
      fullName: json['fullName'],
      imageCover: json['imageCover'],
      email: json['email'],
    );
  }
}
