import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/features/notification_signalr/signalr_service.dart';

import '../../core/helpers/adaptive_indecator.dart';
import '../../utill/constant.dart';
import 'cuibt/bloc_event.dart';
import 'cuibt/notification_bloc.dart';
import 'cuibt/notification_state.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(SignalRService())..add(GetAllNotifications()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is NotificationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is NotificationLoading) {
              return Center(child: AdaptiveIndicator(os: getOS()));
            } else if (state is NotificationLoaded) {
              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return ListTile(
                    title: Text(notification.title),
                    subtitle: Text('${notification.message}\n${notification.dateTime}'),
                  );
                },
              );
            } else if (state is NotificationError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No notifications found'));
            }
          },
        ),
      ),
    );
  }
}
