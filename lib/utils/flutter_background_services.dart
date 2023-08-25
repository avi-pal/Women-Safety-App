import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';


Future<void> initializeService() async{
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "script academy",
    "foregrounf service",
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: "script academy",
      initialNotificationTitle: "foregrounf service",
      initialNotificationContent: "initializing",
      foregroundServiceNotificationId: 888,
    ));
    service.startService();

  
}

@pragma('vm-entry-point')
    void onStart(ServiceInstance service) async{
      DartPluginRegistrant.ensureInitialized();
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      if(service is And)
    
    }