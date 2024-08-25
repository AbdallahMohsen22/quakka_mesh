import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/user.dart';

abstract class UserChatState {}

class UserChatInitial extends UserChatState {}

class UserChatLoading extends UserChatState {}

class UserChatLoaded extends UserChatState {
  final List<User> users;

  UserChatLoaded({required this.users});
}

class UserChatError extends UserChatState {
  final String error;

  UserChatError({required this.error});
}

class ChatCubit extends Cubit<UserChatState> {
  ChatCubit() : super(UserChatInitial());

   //List<User> user = [];

  void fetchUsers(String currentUserId) async {
    emit(UserChatLoading());
    try {
      final response = await http.get(Uri.parse('http://quokkamesh-001-site1.etempurl.com/api/Auth/GetAllUser'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<User> users = data.map((userJson) => User.fromJson(userJson)).toList();

        // Print user IDs and filter out the current user
        users = users.where((user) {
          print('User ID: ${user.id}');
          return user.id != currentUserId;
        }).toList();

        emit(UserChatLoaded(users: users));
        print("Users =====>>>>${data}");
      } else {
        emit(UserChatError(error: 'Failed to load users'));
      }
    } catch (e) {
      emit(UserChatError(error: e.toString()));
    }
  }

  // Future<void> sendMessage({
  //    String? fromUserId,
  //    String? toUserId,
  //    String? message,
  // }) async {
  //   final url = 'http://quokkamesh-001-site1.etempurl.com/api/Chat/SendMessage';
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode({
  //       'FromUserId': fromUserId,
  //       'ToUserId': toUserId,
  //       'Message': message,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     print('Message sent: $responseData');
  //   } else {
  //     print('Failed to send message: ${response.statusCode}');
  //   }
  // }
}
