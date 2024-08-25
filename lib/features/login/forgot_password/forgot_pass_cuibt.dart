
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmailSending extends EmailState {}

class EmailSent extends EmailState {
  final String message;

  EmailSent(this.message);

  @override
  List<Object> get props => [message];
}

class EmailSendError extends EmailState {
  final String error;

  EmailSendError(this.error);

  @override
  List<Object> get props => [error];
}

class EmailCubit extends Cubit<EmailState> {
  EmailCubit() : super(EmailSending());

  Future<void> sendEmail(String email) async {
    final String url = 'http://quokkamesh-001-site1.etempurl.com/api/Email/Send Email/${email}';

    try {
      emit(EmailSending());

      final response = await http.post(Uri.parse(url),
          headers: {

            'Content-Type': 'application/json',
          },
          );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody.contains('Send OTP Successfully')) {
          emit(EmailSent('Send OTP Successfully'));
        } else {
          emit(EmailSendError('Failed to send email.'));
        }
      } else {
        emit(EmailSendError('Failed to send email. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(EmailSendError('Error sending email: $e'));
    }
  }
}
