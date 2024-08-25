
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/notification_model.dart';
import '../signalr_service.dart';
import 'bloc_event.dart';
import 'notification_state.dart';
import 'package:http/http.dart' as http;


class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final String getAllNotificationsUrl = 'http://quokkamesh-001-site1.etempurl.com/api/Notification/GetAllNotification';
  final SignalRService signalRService;

  NotificationBloc(this.signalRService) : super(NotificationInitial()) {
    on<SendNotification>(_onSendNotification);
    on<GetAllNotifications>(_onGetAllNotifications);

    _initializeSignalR();
  }

  Future<void> _initializeSignalR() async {
    await signalRService.initSignalR('http://quokkamesh-001-site1.etempurl.com/notification');
    signalRService.onReceiveMessage((arguments) {
      add(GetAllNotifications());
    });
  }

  Future<void> _onSendNotification(SendNotification event, Emitter<NotificationState> emit) async {
    if (!signalRService.isInitialized) {
      emit(NotificationError('SignalR service not initialized'));
      return;
    }

    emit(NotificationLoading());
    try {
      await signalRService.sendNotification(event.title, event.message);
      add(GetAllNotifications());
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onGetAllNotifications(GetAllNotifications event, Emitter<NotificationState> emit) async {
    if (!signalRService.isInitialized) {
      emit(NotificationError('SignalR service not initialized'));
      return;
    }

    emit(NotificationLoading());
    try {
      final response = await http.get(Uri.parse(getAllNotificationsUrl));

      if (response.statusCode == 200) {
        final List jsonResponse = json.decode(response.body);
        final notifications = jsonResponse.map((data) => NotificationModel.fromJson(data)).toList();
        emit(NotificationLoaded(notifications));
      } else {
        emit(NotificationError('Failed to load notifications'));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    signalRService.dispose();
    return super.close();
  }
}
