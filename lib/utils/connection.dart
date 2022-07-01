import 'package:connectivity_plus/connectivity_plus.dart';

Stream<bool> isOnlineStream() async* {
  yield await isOnline();
  await for (final connectivity in Connectivity().onConnectivityChanged) {
    yield connectivity != ConnectivityResult.none;
  }
}

Future<bool> isOnline() async {
  return (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
}
