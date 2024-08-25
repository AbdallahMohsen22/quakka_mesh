
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  late final HubConnection _hubConnection;
  bool _isInitialized = false;

  Future<void> initSignalR(String url) async {
    _hubConnection = HubConnectionBuilder()
        .withUrl(url)
        .build();

    await _hubConnection.start();
    _isInitialized = true;
  }

  bool get isInitialized => _isInitialized;

  void onReceiveMessage(Function(List<Object?>? arguments) handler) {
    _hubConnection.on('ReceiveMessage', handler);
  }

  Future<void> sendNotification(String title, String message) async {
    await _hubConnection.invoke('SendNotification', args: [title, message]);
  }

  void dispose() {
    _hubConnection.stop();
  }
}
