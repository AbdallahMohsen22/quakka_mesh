

// Define ResetPassword States
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ResetPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordInProgress extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String message;

  ResetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordFailure extends ResetPasswordState {
  final String error;

  ResetPasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Define ResetPassword Cubit
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final String url = 'http://quokkamesh-001-site1.etempurl.com/api/Email/ResetPassword';

    try {
      emit(ResetPasswordInProgress());

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Content-Type'] = 'application/json'
        ..fields['Email'] = email
        ..fields['NewPassword'] = newPassword
        ..fields['ConfirmPassword'] = confirmPassword;

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        if (responseBody.contains("Changed Successfully...")) {
          emit(ResetPasswordSuccess('Password reset successfully.'));
          print("Api Response====>>>>${responseBody}");

        } else {
          emit(ResetPasswordFailure('Unexpected response: $responseBody'));
        }
      } else {
        emit(ResetPasswordFailure('Failed to reset password. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ResetPasswordFailure('Error resetting password: $e'));
    }
  }
}
