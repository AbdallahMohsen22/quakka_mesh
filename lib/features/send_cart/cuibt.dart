import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class SendCartState {}

class SendCartInitial extends SendCartState {}

class SendCartLoading extends SendCartState {}

class SendCartSuccess extends SendCartState {
  final Map<String, dynamic> cartData;

  SendCartSuccess(this.cartData);
}

class SendCartFailure extends SendCartState {
  final String error;

  SendCartFailure(this.error);
}

class SendCartCubit extends Cubit<SendCartState> {
  SendCartCubit() : super(SendCartInitial());

  void sendCart({
    required String userId,
    required String receiverId,
    required int cartId,
    required DateTime createdDate,
    required String title,
    required String content,
    required String sender,
    required String receiver,
    required bool isPremium,
  }) async {
    emit(SendCartLoading());
    try {
      var uri = Uri.parse('http://quokkamesh-001-site1.etempurl.com/api/SendCart/User/SendCart?userId=$userId&ReceiverId=$receiverId&cartId=$cartId');
      var request = http.MultipartRequest('POST', uri);

      request.fields['Titel'] = title;
      request.fields['Sender'] = sender;
      request.fields['Receiver'] = receiver;
      request.fields['Content'] = content;
      request.fields['IsPremium'] = isPremium.toString();
      request.fields['Created'] = createdDate.toIso8601String();

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        emit(SendCartSuccess(data));
        print("API Response ======>>>>>${data}");
      } else {
        final responseData = await response.stream.bytesToString();
        final error = jsonDecode(responseData)['errors'];
        emit(SendCartFailure(error.toString()));
      }
    } catch (e) {
      emit(SendCartFailure(e.toString()));
    }
  }
}
