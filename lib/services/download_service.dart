// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';

// class DownloadService {
//   static Future<DownloadService> setup() async {
//     return downloadService;
//   }

//   void onStart(ServiceInstance service) {
//     if (service is! AndroidServiceInstance) throw Error();
//     WidgetsFlutterBinding.ensureInitialized();

//     service.setForegroundNotificationInfo(
//       title: "title",
//       content: "content",
//     );

//     service.setAsForegroundService();
//   }
// }
