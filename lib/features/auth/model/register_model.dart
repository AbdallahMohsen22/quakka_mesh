
import 'package:image_picker/image_picker.dart';

class RegisterModel {
  final String fullName;
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final XFile imageCover;

  RegisterModel({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.imageCover,
  });

  Future<Map<String, String>> toFormData() async {
    return {
      'FullName': fullName,
      'Username': username,
      'Email': email,
      'Password': password,
      'Phonenumber': phoneNumber,
      // 'ImageCover': imageCover.path, // We handle imageCover differently
    };
  }
}
