import 'package:flutter/foundation.dart';
import 'package:mobile_lingkunganku/misc/api_url.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../modules/app/bloc/app_bloc.dart';
import 'injections.dart';

enum ConnectionIndicator { red, yellow, green }

class SocketServices with ChangeNotifier, DiagnosticableTreeMixin {
  static final shared = SocketServices();
  IO.Socket? socket;
  bool isConnected = false;

  ConnectionIndicator _connectionIndicator = ConnectionIndicator.yellow;
  ConnectionIndicator get connectionIndicator => _connectionIndicator;

  void setStateConnectionIndicator(ConnectionIndicator connectionIndicators) {
    _connectionIndicator = connectionIndicators;

    Future.delayed(Duration.zero, () => notifyListeners());
  }

  void toggleConnection(bool connection) {
    isConnected = connection;

    Future.delayed(Duration.zero, () => notifyListeners());
  }

  init({String? myTokenLogin}) async {
    String token = getIt<AppBloc>().state.token;
    debugPrint("Token : $token");

    socket = IO.io(
        MyApi.baseUrlSocket,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'Authorization': token}) // optional
            .disableAutoConnect()
            .enableForceNew()
            .enableForceNewConnection()
            .build());

    socket?.connect();

    socket?.onConnect((_) {
      setStateConnectionIndicator(ConnectionIndicator.yellow);
      Future.delayed(const Duration(seconds: 1), () {
        setStateConnectionIndicator(ConnectionIndicator.green);
        toggleConnection(true);
      });
      isConnected = true;
      print('On Connect');
    });

    socket?.onReconnect((_) {
      isConnected = true;
      setStateConnectionIndicator(ConnectionIndicator.red);
      print('On Reconnect');

      /// rejoin global init if have
    });

    socket?.on('listen:confirmcase', (data) async {});

    socket?.onDisconnect((_) {
      setStateConnectionIndicator(ConnectionIndicator.red);
      isConnected = false;
      print('disconnect');
    });

    socket?.onError((_) {
      setStateConnectionIndicator(ConnectionIndicator.red);
      isConnected = false;
      print(
        'error sockect : $_',
      );
    });
  }

  void connect() {
    print("On Connect Socket");
    init();
    isConnected = true;
  }

  void allClose() {
    socket?.off('listen:confirmcase');
    socket?.disconnect();
    print("On Disconnect Socket");
    socket?.close();
    socket = null;
    setStateConnectionIndicator(ConnectionIndicator.red);
    isConnected = false;
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', count));
  }
}
