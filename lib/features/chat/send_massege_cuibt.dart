
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../../basic_constants.dart';
import 'model/chat_model.dart';


class SendMessageState {}
bool isClosed = false;
class SendMessageInitial extends SendMessageState {}
class SendMessageLoading extends SendMessageState {}
class SendMessageSuccess extends SendMessageState {
  final MessageModel messageModel;

  SendMessageSuccess(this.messageModel);
}
class SendMessageError extends SendMessageState {
  final String error;

  SendMessageError(this.error);
}
/////////////////////////////////////////////////////////
//send
class SendMessageSuccessState extends SendMessageState {}
class SendMessageErrorState extends SendMessageState {}
//get
class GetMessageSuccessState extends SendMessageState {}
class GetMessageErrorState extends SendMessageState {}




class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(SendMessageInitial());
  // Future<void> sendMessage({
  //   required String fromUserId,
  //   required String toUserId,
  //   required String message,
  // }) async {
  //   emit(SendMessageLoading());
  //
  //   final url = 'http://quokkamesh-001-site1.etempurl.com/api/Chat/SendMessage';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //       },
  //       body: {
  //         'FromUserId': fromUserId,
  //         'ToUserId': toUserId,
  //         'Message': message,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       final messageModel = MessageModel.fromJson(responseData);
  //       emit(SendMessageSuccess(messageModel));
  //       print("Response ====>>>>${responseData}");
  //     } else {
  //       emit(SendMessageError('Failed to send message: ${response.statusCode}'));
  //     }
  //   } catch (e) {
  //     emit(SendMessageError(e.toString()));
  //   }
  // }

  @override
  Future<void> close() {
    isClosed = true;
    return super.close();
  }

  void sendMessage({
    String? receiverId,
    String? dateTime,
    String? text,
  }) {
    MessageModel model = MessageModel(
      senderId: userId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );

    _sendMessage(model, receiverId);
  }

  void sendImage({
    String? receiverId,
    String? dateTime,
    String? imageUrl,
  }) {
    MessageModel model = MessageModel(
      senderId: userId,
      receiverId: receiverId,
      dateTime: dateTime,
      imageUrl: imageUrl,
    );

    _sendMessage(model, receiverId);
  }

  void sendSticker({
    String? receiverId,
    String? dateTime,
    String? stickerUrl,
  }) {
    MessageModel model = MessageModel(
      senderId: userId,
      receiverId: receiverId,
      dateTime: dateTime,
      stickerUrl: stickerUrl,
    );

    _sendMessage(model, receiverId);
  }

  void _sendMessage(MessageModel model, String? receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      if (!isClosed) emit(SendMessageSuccessState());
      print("Success");
    }).catchError((error) {
      if (!isClosed) emit(SendMessageErrorState());
      print("Error");
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      if (!isClosed) emit(SendMessageSuccessState());
      print("Success");
    }).catchError((error) {
      if (!isClosed) emit(SendMessageErrorState());
      print("Error");
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetMessageSuccessState());
    });
  }
}





