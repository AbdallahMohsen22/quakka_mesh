
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class UserCountState extends Equatable {
  const UserCountState();

  @override
  List<Object> get props => [];
}

class UserCountInitial extends UserCountState {}

class UserCountLoading extends UserCountState {}

class UserCountLoaded extends UserCountState {
  final int userCount;

  const UserCountLoaded(this.userCount);

  @override
  List<Object> get props => [userCount];
}

class UserCountError extends UserCountState {
  final String error;

  const UserCountError(this.error);

  @override
  List<Object> get props => [error];
}

class UserCountCubit extends Cubit<UserCountState> {
  UserCountCubit() : super(UserCountInitial());

  Future<void> fetchUserCount() async {
    final String url = 'http://quokkamesh-001-site1.etempurl.com/api/Statistics/Admin/CountAllUser';

    try {
      emit(UserCountLoading());
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final int userCount = responseBody['numbers'];
        emit(UserCountLoaded(userCount));
        print("Api Response====>>>>>> ${userCount}");
      } else {
        emit(UserCountError('Failed to load user count. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(UserCountError('Error loading user count: $e'));
    }
  }
}
