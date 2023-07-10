import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:women_safety_app/widgets/home_widgets/livesafe/BusStationCard.dart';
import 'package:women_safety_app/widgets/home_widgets/livesafe/HospitalCard.dart';
import 'package:women_safety_app/widgets/home_widgets/livesafe/PharmacyCard.dart';
import 'package:women_safety_app/widgets/home_widgets/livesafe/PoliceStationCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static Future<void> openMap(String location) async {
    String googleUrl = "https://www.google.com/maps/search/$location";
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong! Call Emergency Number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            PoliceStationCard(
              onMapFunction: openMap,
            ),
            HospitalCard(onMapFunction: openMap),
            PharmacyCard(onMapFunction: openMap),
            BusStationCard(onMapFunction: openMap)
          ],
        ));
  }
}
