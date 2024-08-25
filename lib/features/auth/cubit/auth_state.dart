// part of 'auth_cubit.dart';
//
// @immutable
// abstract class AuthState {}
//
// class AuthInitial extends AuthState {}
//
// class AuthRegisterSuccessState extends AuthState {
//   late final UserResponse userModel;
//   AuthRegisterSuccessState(this.userModel);
// }
//
// class AuthRegisterErrorState extends AuthState {
//   final String errorMessage;
//
//   AuthRegisterErrorState({ required this.errorMessage});
// }
// class AuthRegisterLoadingState extends AuthState {}
//
//
import '../../login/model/user_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserModel user;

  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}
