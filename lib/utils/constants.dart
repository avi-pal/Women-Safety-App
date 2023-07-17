// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:women_safety_app/child/register_child.dart';

Color primaryColor = Color(0xfffc3b77);

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}

progressIndicator(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
              child: CircularProgressIndicator(
            backgroundColor: primaryColor,
            color: Color.fromARGB(255, 193, 182, 182),
            strokeWidth: 7,
          )));
}
