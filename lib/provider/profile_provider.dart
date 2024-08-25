// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// import '../core/network/api_constants.dart';
// import '../features/profile/model/profile_model.dart';
//
// class UserProfileProvider extends ChangeNotifier {
//   UserProfile? _userProfile;
//   bool _isLoading = false;
//   bool _isDeleting = false;
//   bool get isDeleting => _isDeleting;
//   final Dio _dio = Dio();
//   UserProfile? get userProfile => _userProfile;
//
//   Future<void> fetchUserProfile() async {
//     try {
//       final response = await _dio.get('${ApiConstants.baseUrl}${ApiConstants.getOneUser}/2ae23180-f3dc-400b-a73b-e607194ccee0');
//       if (response.statusCode == 200) {
//         _userProfile = UserProfile.fromJson(response.data);
//         notifyListeners();
//       } else {
//         // Handle errors
//         print('Failed to fetch user profile: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle Dio errors or network errors
//       print('Error fetching user profile: $e');
//     }
//   }
//
//   Future<void> updateUserProfile(UserProfile updatedProfile) async {
//     try {
//       final response = await _dio.put
//         ('${ApiConstants.baseUrl}${ApiConstants.updateSubProfile}', data: {
//         'FullName': updatedProfile.fullName,
//         'Username': updatedProfile.userName,
//         'Email': updatedProfile.email,
//         'Password': updatedProfile.password,
//         'Phonenumber': updatedProfile.phone,
//       });
//       if (response.statusCode == 200) {
//         _userProfile = updatedProfile;
//         notifyListeners();
//       } else {
//         // Handle errors
//         print('Failed to update user profile: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle Dio errors or network errors
//       print('Error updating user profile: $e');
//     }
//   }
// }
