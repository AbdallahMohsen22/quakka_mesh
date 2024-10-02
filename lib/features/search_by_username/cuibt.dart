
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/features/search_by_username/receiver_model.dart';


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


class UserInitialInfo extends UserState {}

class UserLoadingInfo extends UserState {}

class UserLoadedInfo extends UserState {
  final dynamic user;

  UserLoadedInfo(this.user);
}

class UserErrorInfo extends UserState {
  final String message;

  UserErrorInfo(this.message);
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

  //searchUsers
  void searchUsers(String username) async {
    emit(UserLoading());
    try {
      var response = await http.get(Uri.parse('http://backend.quokka-mesh.com/api/SendCart/SearchInAllUser/$username'));
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
  //     var response = await http.get(Uri.parse('http://backend.quokka-mesh.com/api/Auth/GetAllUser'));
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

  void fetchUser(String userId) async {
    emit(UserLoadingInfo());
    try {
      final response = await http.get(Uri.parse('http://backend.quokka-mesh.com/api/Auth/GetOneUser?userId=$userId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(UserLoadedInfo(data[0])); // Assuming it's a list with one user
      } else {
        emit(UserErrorInfo('Failed to load user'));
      }
    } catch (e) {
      emit(UserErrorInfo('An error occurred'));
    }
  }
}
