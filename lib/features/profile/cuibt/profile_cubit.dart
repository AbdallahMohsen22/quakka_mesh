
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
class ProfileState extends Equatable {
  final String fullName;
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final bool isAdmin;
  final String? imageCoverPath;

  ProfileState({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.isAdmin,
    this.imageCoverPath,
  });

  @override
  List<Object?> get props => [fullName, username, email, password, phoneNumber, isAdmin, imageCoverPath];

  ProfileState copyWith({
    String? fullName,
    String? username,
    String? email,
    String? password,
    String? phoneNumber,
    bool? isAdmin,
    String? imageCoverPath,
  }) {
    return ProfileState(
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdmin: isAdmin ?? this.isAdmin,
      imageCoverPath: imageCoverPath ?? this.imageCoverPath,
    );
  }
}

class ProfileUpdating extends ProfileState {
  ProfileUpdating() : super(
    fullName: '',
    username: '',
    email: '',
    password: '',
    phoneNumber: '',
    isAdmin: false,
  );
}

class ProfileUpdated extends ProfileState {
  final String message;

  ProfileUpdated({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required bool isAdmin,
    String? imageCoverPath,
    required this.message,
  }) : super(
    fullName: fullName,
    username: username,
    email: email,
    password: password,
    phoneNumber: phoneNumber,
    isAdmin: isAdmin,
    imageCoverPath: imageCoverPath,
  );

  @override
  List<Object?> get props => [fullName, username, email, password, phoneNumber, isAdmin, imageCoverPath, message];
}

class ProfileUpdateError extends ProfileState {
  final String error;

  ProfileUpdateError(this.error) : super(
    fullName: '',
    username: '',
    email: '',
    password: '',
    phoneNumber: '',
    isAdmin: false,
  );

  @override
  List<Object?> get props => [error];
}






class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileUpdating());

  // Future<void> loadProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? fullName = prefs.getString('fullName');
  //   String? username = prefs.getString('username');
  //   String? email = prefs.getString('email');
  //   String? password = prefs.getString('password');
  //   String? phoneNumber = prefs.getString('phoneNumber');
  //   bool isAdmin = prefs.getBool('isAdmin') ?? false;
  //   String? imageCoverPath = prefs.getString('imageCoverPath');
  //
  //   emit(ProfileState(
  //     fullName: fullName ?? '',
  //     username: username ?? '',
  //     email: email ?? '',
  //     password: password ?? '',
  //     phoneNumber: phoneNumber ?? '',
  //     isAdmin: isAdmin,
  //     imageCoverPath: imageCoverPath,
  //   ));
  // }
  //
  // Future<void> saveProfile({
  //   required String fullName,
  //   required String username,
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required bool isAdmin,
  //   String? imageCoverPath,
  // }) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('fullName', fullName);
  //   await prefs.setString('username', username);
  //   await prefs.setString('email', email);
  //   await prefs.setString('password', password);
  //   await prefs.setString('phoneNumber', phoneNumber);
  //   await prefs.setBool('isAdmin', isAdmin);
  //   if (imageCoverPath != null) {
  //     await prefs.setString('imageCoverPath', imageCoverPath);
  //   }
  // }

  Future<void> updateProfile({
    required String id,
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    bool isAdmin = false,
    File? imageCover,
  }) async {
    final String url = 'http://backend.quokka-mesh.com/api/Auth/UpdateSubProfile/$id';

    try {
      emit(ProfileUpdating());

      var request = http.MultipartRequest('PUT', Uri.parse(url))
        ..fields['FullName'] = fullName
        ..fields['Username'] = username
        ..fields['Email'] = email
        ..fields['Password'] = password
        ..fields['Phonenumber'] = phoneNumber
        ..fields['IsAdmin'] = isAdmin.toString();

      String? imageCoverPath;
      if (imageCover != null) {
        imageCoverPath = imageCover.path;
        request.files.add(await http.MultipartFile.fromPath(
          'ImageCover',
          imageCover.path,
          filename: basename(imageCover.path),
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        // await saveProfile(
        //   fullName: fullName,
        //   username: username,
        //   email: email,
        //   password: password,
        //   phoneNumber: phoneNumber,
        //   isAdmin: isAdmin,
        //   imageCoverPath: imageCoverPath,
        // );

        emit(ProfileUpdated(
          fullName: fullName,
          username: username,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          isAdmin: isAdmin,
          imageCoverPath: imageCoverPath,
          message: 'Profile updated successfully',
        ));
        print("<<<<<Profile updated successfully>>>>>");

      } else {
        emit(ProfileUpdateError('Failed to update profile. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProfileUpdateError('Error updating profile: $e'));
    }
  }
}
