
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/features/search_by_username/receiver_model.dart';

import '../chat/model/user.dart';

class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<ReceiverUser> users;

  UserSuccess(this.users);
}

class UserFailure extends UserState {
  final String error;

  UserFailure(this.error);
}
/////////////////////////////////////////////

// class GetallUserInitial extends UserState {}
//
// class GetallUserLoading extends UserState {}
//
// class GetallUserSuccess extends UserState {
//   final List<User> users;
//
//   GetallUserSuccess(this.users);
// }
//
// class GetallUserFailure extends UserState {
//   final String error;
//
//   GetallUserFailure(this.error);
// }


class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void searchUsers(String username) async {
    emit(UserLoading());
    try {
      var response = await http.get(Uri.parse('http://quokkamesh-001-site1.etempurl.com/api/SendCart/SearchInAllUser/$username'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> userData = data['result'];
        List<ReceiverUser> users = userData.map((item) => ReceiverUser.fromJson(item)).toList();
        emit(UserSuccess(users));
        print("API Response data  ======>>>>>> ${data}");
        print("API Response users ======>>>>>> ${users}");
      } else {
        emit(UserFailure('Failed to search users'));
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  // List<User> users = [];
  //
  // void getUsers() async{
  //   emit(GetallUserLoading());
  //   try {
  //     var response = await http.get(Uri.parse('http://quokkamesh-001-site1.etempurl.com/api/Auth/GetAllUser'));
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = json.decode(response.body);
  //       List<dynamic> userData = data['result'];
  //       List<User> users = userData.map((item) => User.fromJson(item)).toList();
  //       emit(GetallUserSuccess(users));
  //       print("API Response data  ======>>>>>> ${data}");
  //       print("API Response Getall users ======>>>>>> ${users}");
  //     } else {
  //       emit(GetallUserFailure('Failed to search users'));
  //     }
  //   } catch (e) {
  //     emit(GetallUserFailure(e.toString()));
  //   }
  //
  // }
}
