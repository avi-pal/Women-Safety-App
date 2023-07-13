import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/constants.dart';

import 'components/custom_textfield.dart';
import 'components/primaryButton.dart';
import 'components/secondaryButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = false;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String,Object>();


  _onSubmit(){
    _formKey.currentState!.save();
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
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
                Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          hintText: "Enter Email",
                          isPassword: false,
                          textInputAction:TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          prefix: Icon(Icons.person),
                          onsave: (email){
                            _formData['email'] = email ?? "";
                          },
                          validate: (email){
                            if(
                              email!.isEmpty||
                              email.length<3||
                              !email.contains("@")
                            ){
                              return 'enter correct email';
                            }
                          },
                        ),
                        CustomTextField(
                          hintText: "Enter Password",
                          isPassword: isPasswordShown,
                          prefix: Icon(Icons.vpn_key_rounded),
                          onsave: (password){
                            _formData['password'] = password ?? "";
                          },
                           validate: (password){
                              if(
                                password!.isEmpty||
                                password.length<7
                              ){
                                return 'enter correct password';
                              }
                           },
                          suffix: IconButton(onPressed: (){
                            setState(() {
                              isPasswordShown = !isPasswordShown;
                            });
                            
                          }, icon: isPasswordShown?Icon(Icons.visibility_off):Icon(Icons.visibility)
                          ),
                          
                        ),
                        PrimaryButton(title: 'REGISTER', onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _onSubmit();
                          }
                        },),
                      ]
                    ),
                  ),
                ),
                Container(
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
            ),
          )
        )
      ),
    );
  }
}