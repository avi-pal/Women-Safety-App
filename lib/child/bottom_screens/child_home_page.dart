import 'dart:math';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:women_safety_app/widgets/home_widgets/CustomCarousel.dart';
import 'package:women_safety_app/widgets/home_widgets/custom_appBar.dart';
import 'package:women_safety_app/widgets/home_widgets/safehome/SafeHome.dart';
import 'package:women_safety_app/widgets/live_safe.dart';
import 'package:women_safety_app/widgets/home_widgets/emergency.dart';

import '../../db/db_services.dart';
import '../../model/contactsm.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({super.key});
  int qIndex = 2;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;

  _isPermissionGranted() async => await Permission.sms.isGranted;

  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  getRandomQuote() {
    Random random = Random();

    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  _getAndSendSms() async{
     List<TContact> contactList =
                          await DatabaseHelper().getContactList();
                      print(contactList.length);
                      
                      if (contactList.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "emergency contact is empty");
                      } else {
                        // _sendSms("09163318729", "Hello", simSlot: 1);
                        String messageBody =
                            "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";

                        print("Hello1");
                        if (await _isPermissionGranted()) {
                          print("Hello");
                          contactList.forEach((element) {
                            print(element.number);
                            _sendSms("${element.number}",
                                "i am in trouble $messageBody",simSlot: 1);
                          });
                        } else {
                          Fluttertoast.showToast(msg: "permission required");
                          Permission.sms.request();
                        }
                     }
  }

  @override
  void initState(){

    _getCurrentLocation();

    getRandomQuote();
    super.initState();
    ///////shake features///////
    // ShakeDetector.autoStart(
    //   onPhoneShake: () {
    //     _getAndSendSms();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('Shake!'),
    //       ),
    //     );
    //     // Do stuff on phone shake
    //   },
    //   minimumShakeCount: 2,
    //   shakeSlopTimeMS: 500,
    //   shakeCountResetTime: 3000,
    //   shakeThresholdGravity: 2.7,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppBar(
                  quoteIndex: qIndex,
                  onTap: () {
                    getRandomQuote();
                  }),
              Expanded(
                  child: ListView(shrinkWrap: true, children: [
                CustomCarousel(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Emergency",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Emergency(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Explore LiveSafe",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                LiveSafe(),
                SafeHome(),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
