import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';

class Connection {
  Connection({
    required this.host,
  }) {
    setup();
  }

  void setup() async {
    final value = (await Connectivity().checkConnectivity()) != ConnectivityResult.none &&
        await _checkConnection();
    _value = value;
    _controller.sink.add(value);

    Connectivity().onConnectivityChanged.listen((connectivity) async {
      final value = connectivity != ConnectivityResult.none && await _checkConnection();
      if (value == _value) return;
      _value = value;
      _controller.sink.add(value);
    });
  }

  final String host;

  final _controller = StreamController<bool>.broadcast();
  bool _value = false;

  Stream<bool> listen() async* {
    yield _value;
    yield* _controller.stream;
  }

  /// Check if the app can connect to the server
  Future<bool> _checkConnection() async {
    final response = await get(Uri.parse("$host/connecttest"));
    return response.statusCode == 200;
  }
}
