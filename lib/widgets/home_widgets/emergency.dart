import 'package:flutter/material.dart';
import 'emargencies/ambulanceemargency.dart';
import 'emargencies/firebrigadeemargency.dart';
import 'emargencies/policeemargency.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),

        ],
      ),
    );
  }
}