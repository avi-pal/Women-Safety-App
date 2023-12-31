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

Widget progressIndicator(BuildContext context) {
  return Center(
              child: CircularProgressIndicator(
            backgroundColor: primaryColor,
            color: Color.fromARGB(255, 193, 182, 182),
            strokeWidth: 7,
          ));
}



//parent ankitsahanaihati@gmail.com  p/w: 1qaz2wsx
//child sahaankit0701@gmail.com p/w:2wsx1qaz