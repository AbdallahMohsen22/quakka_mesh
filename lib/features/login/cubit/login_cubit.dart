
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../basic_constants.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/shared_constabts.dart';
import '../model/user_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  // final LoginRepo _loginRepo;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //newPassword
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  TextEditingController otpController = TextEditingController();

  final formKey = GlobalKey<FormState>();



  // void emitLoginStates() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   emit(const LoginState.loading());
  //   final response = await _loginRepo.login(
  //     email: emailController.text,
  //     password: passwordController.text,
  //   );
  //   response.when(success: (loginResponse) {
  //     emit(LoginState.success(loginResponse));
  //     print("Api Response===>>>>>${loginResponse.email}");
  //     prefs.setBool('isAuth', true);
  //     // prefs.setBool('isAdmin', loginResponse.isAdmin);
  //     prefs.setString('userId', loginResponse.id);
  //     prefs.setString('token', loginResponse.token);
  //     isSignIn = true;
  //     // isAdmin = loginResponse.isAdmin;
  //     userId = loginResponse.id;
  //     userToken = loginResponse.token;
  //
  //
  //   }, failure: (error) {
  //     emit(LoginState.error(error: error.apiErrorModel.messages ?? ''));
  //     print("Api Response===>>>>>${error.toString()}");
  //   });
  // }
  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}'),
        body: {
          'Email': email,
          'Password': password,
        },
      );

      if (response.statusCode == 200) {
        var prefs = await SharedPreferences.getInstance();
        final data = json.decode(response.body);
        final user = UserModel.fromJson(data);

        emit(LoginSuccess(user));
        Constants.showToast(msg: "Login Success",
            gravity: ToastGravity.BOTTOM,
            color: Colors.green);

        prefs.setBool('isAuth', true);
        prefs.setBool('isAdmin', user.result!.isAdmin!);
        prefs.setString('userId', user.result!.id!);
        prefs.setString('token', user.result!.token!);
        isSignIn = true;
        isAdmin = user.result!.isAdmin;
        userId = user.result!.id;
        userToken = user.result!.token;
        print("API Login Response===>>>> ${data}");
        print("isAdmin ===>>>> ${user.result!.isAdmin}");
        print("UId===>>>> ${user.result!.id}");
      } else {
        emit(LoginFailure('Invalid credentials'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

}

