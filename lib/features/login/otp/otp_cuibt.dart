

// Otp Cubit States
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class OtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpVerifying extends OtpState {}

class OtpVerified extends OtpState {
  final String message;

  OtpVerified(this.message);

  @override
  List<Object> get props => [message];
}

class OtpVerificationError extends OtpState {
  final String error;

  OtpVerificationError(this.error);

  @override
  List<Object> get props => [error];
}

// Otp Cubit
class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  Future<void> verifyOtp(String otp) async {
    final String url = 'http://backend.quokka-mesh.com/api/Email/Send Confirmation Email/$otp';

    try {
      emit(OtpVerifying());

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody.contains('Verify Successfully...')) {
          emit(OtpVerified('Verify Successfully...'));
        } else {
          emit(OtpVerificationError('Failed to verify OTP.'));
        }
      } else {
        emit(OtpVerificationError('Failed to verify OTP. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(OtpVerificationError('Error verifying OTP: $e'));
    }
  }
}
