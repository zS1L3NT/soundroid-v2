import 'package:api_repository/api_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Stream<bool> isOnlineStream(ApiRepository apiRepo) async* {
  bool previousValue = await isOnline(apiRepo);
  yield previousValue;

  await for (final connectivity in Connectivity().onConnectivityChanged) {
    final value = connectivity != ConnectivityResult.none && await apiRepo.checkConnection();
    if (value == previousValue) continue;
    previousValue = value;
    yield value;
  }
}

Future<bool> isOnline(ApiRepository apiRepo) async {
  return (await Connectivity().checkConnectivity()) != ConnectivityResult.none &&
      await apiRepo.checkConnection();
}
