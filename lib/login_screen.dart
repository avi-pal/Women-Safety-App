import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/constants.dart';

import 'components/custom_textfield.dart';
import 'components/primaryButton.dart';
import 'components/secondaryButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "USER LOGIN",
                        style: TextStyle(fontSize: 40, fontWeight:FontWeight.bold,color: primaryColor),
                      ),
                      Image.asset(
                        'assets/logo.png',
                        height: 100,
                        width: 100,
                      ),
                    ]
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextField(
                        hintText: "enter name",
                        prefix: Icon(Icons.person),
                      ),
                      CustomTextField(
                        hintText: "enter Password",
                        prefix: Icon(Icons.person),
                      ),
                      PrimaryButton(title: 'REGISTER', onPressed: (){},),
                    ]
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 18),
                    ),
                    SecondaryButton(title: 'Click here',onPressed:(){}),
                  ]
                ),
              ),
              SecondaryButton(title: 'Register new user',onPressed:(){}),
            ],
          )
        )
      ),
    );
  }
}