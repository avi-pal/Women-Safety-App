import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/components/custom_textfield.dart';
import 'package:women_safety_app/components/primaryButton.dart';
import 'package:women_safety_app/components/secondaryButton.dart';
import 'package:women_safety_app/child/child_login_screen.dart';
import 'package:women_safety_app/model/user_model.dart';
import 'package:women_safety_app/utils/constants.dart';

class RegisterChildScreen extends StatefulWidget {
  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  bool isPasswordShown = true;
  bool isReTypePasswordShown = true;

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();
  bool isLoading = false;

  _onSubmit() async{
    _formKey.currentState!.save();
    if (_formData['password'].toString() != _formData['rpassword']) {
      dialogueBox(context, "password and retrype password should be same!!");
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _formData["cemail"].toString(),
    password: _formData["password"].toString()
  );
  if(credential.user!=null){
    setState(() {
      isLoading = true;
    });
    final v = credential.user!.uid;
    DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v);
          final user = UserModel(
              name: _formData['name'].toString(),
              phone: _formData['phone'].toString(),
              childEmail: _formData['cemail'].toString(),
              parentEmail: _formData['gemail'].toString(),
              id: v,
              type: 'child');
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            goTo(context, LoginScreen());
            setState(() {
              isLoading = false;
            });
          });
  }
} on FirebaseAuthException catch (e) {
  setState(() {
    isLoading = true;
  });
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    dialogueBox(context, 'The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    dialogueBox(context, 'The account already exists for that email.');
  }
} catch (e) {
  print(e);
  setState(() {
    isLoading = true;
  });
}
    }
    print(_formData['cemail']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading?progressIndicator(context)
              :SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "REGISTER AS A CHILD",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          Image.asset(
                            'assets/logo.png',
                            height: 100,
                            width: 100,
                          ),
                        ]),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                              hintText: "Enter Name",
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              prefix: Icon(Icons.person),
                              onsave: (name) {
                                _formData['name'] = name ?? "";
                              },
                              validate: (name) {
                                if (name!.isEmpty || name.length < 3) {
                                  return 'enter correct name';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: "Enter Phone",
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              prefix: Icon(Icons.phone),
                              onsave: (phone) {
                                _formData['phone'] = phone ?? "";
                              },
                              validate: (phone) {
                                if (phone!.isEmpty || phone.length < 10) {
                                  return 'enter correct phone';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: "Enter Email",
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              onsave: (cemail) {
                                _formData['cemail'] = cemail ?? "";
                              },
                              validate: (cemail) {
                                if (cemail!.isEmpty ||
                                    cemail.length < 3 ||
                                    !cemail.contains("@")) {
                                  return 'enter correct email';
                                }
                              },
                            ),
                            CustomTextField(
                              hintText: "Enter Guardian Email",
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              onsave: (gemail) {
                                _formData['gemail'] = gemail ?? "";
                              },
                              validate: (gemail) {
                                if (gemail!.isEmpty ||
                                    gemail.length < 3 ||
                                    !gemail.contains("@")) {
                                  return 'enter correct guardian email';
                                }
                              },
                            ),
                            CustomTextField(
                              hintText: "Enter Password",
                              isPassword: isPasswordShown,
                              prefix: Icon(Icons.vpn_key_rounded),
                              onsave: (password) {
                                _formData['password'] = password ?? "";
                              },
                              validate: (password) {
                                if (password!.isEmpty || password.length < 7) {
                                  return 'enter correct password';
                                }
                              },
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordShown = !isPasswordShown;
                                    });
                                  },
                                  icon: isPasswordShown
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                            ),
                            CustomTextField(
                              hintText: "Re Type Password",
                              isPassword: isReTypePasswordShown,
                              prefix: Icon(Icons.vpn_key_rounded),
                              onsave: (rpassword) {
                                _formData['rpassword'] = rpassword ?? "";
                              },
                              validate: (rpassword) {
                                if (rpassword!.isEmpty || rpassword.length < 7) {
                                  return 'enter correct password';
                                }
                              },
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isReTypePasswordShown = !isReTypePasswordShown;
                                    });
                                  },
                                  icon: isReTypePasswordShown
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                            ),
                            PrimaryButton(
                              title: 'REGISTER',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _onSubmit();
                                }
                              },
                            ),
                          ]),
                    ),
                  ),
                  SecondaryButton(
                      title: 'Login With Your Account',
                      onPressed: () {
                        goTo(context, LoginScreen());
                      }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
