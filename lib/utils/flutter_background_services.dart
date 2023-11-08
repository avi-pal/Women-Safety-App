import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "script academy",
    "foreground service",
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        notificationChannelId: "script academy",
        initialNotificationTitle: "foreground service",
        initialNotificationContent: "initializing",
        foregroundServiceNotificationId: 888,
      ));
  service.startService();
}

@pragma('vm-entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(Duration(seconds: 2), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                forceAndroidLocationManager: true)
            .then((Position position) {
          print(
              "location detected location detected location detected location detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detectedlocation detected");
          print("bg location ${position.latitude}");
        }).catchError((e) {
          print(
              "error error error error error error error error error error error error error error error error error error error error error error error error error error error error error error");
          Fluttertoast.showToast(msg: e.toString());
        });

        ShakeDetector.autoStart(
            shakeThresholdGravity: 7,
            onPhoneShake: () async {
              if (await Vibration.hasVibrator() ?? false) {
                print("666666");
                if (await Vibration.hasCustomVibrationsSupport() ?? false) {
                  print("888888");
                  Vibration.vibrate(duration: 1000);
                  await Future.delayed(Duration(milliseconds: 500));
                  Vibration.vibrate();
                }
              }
            });
        flutterLocalNotificationsPlugin.show(
            888,
            "women safety app",
            "shake feature enable",
            NotificationDetails(
                android: AndroidNotificationDetails(
                    "script academy", "foreground service",
                    importance: Importance.high,
                    icon: 'ic_bg_service_small',
                    ongoing: true)));
      }
    }
  });
}
