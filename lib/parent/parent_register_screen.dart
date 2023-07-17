import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/components/custom_textfield.dart';
import 'package:women_safety_app/components/primaryButton.dart';
import 'package:women_safety_app/components/secondaryButton.dart';
import 'package:women_safety_app/child/child_login_screen.dart';
import 'package:women_safety_app/utils/constants.dart';

class RegisterParentScreen extends StatefulWidget {
  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
  bool isPasswordShown = false;

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  _onSubmit() {
    _formKey.currentState!.save();
    if (_formData['password'].toString() != _formData['rpassword']) {
      dialogueBox(context, "password and retrype password should be same!!");
    } else {
      progressIndicator(context);
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        auth
            .createUserWithEmailAndPassword(
                email: _formData["email"].toString(),
                password: _formData["password"].toString())
            .whenComplete(
              () => goTo(context, LoginScreen()),
            );
      } on FirebaseAuthException catch (e) {
        dialogueBox(context, e.toString());
      } catch (e) {
        dialogueBox(context, e.toString());
      }
    }
    progressIndicator(context);
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "REGISTER AS A PARENT",
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
                          onsave: (email) {
                            _formData['email'] = email ?? "";
                          },
                          validate: (email) {
                            if (email!.isEmpty ||
                                email.length < 3 ||
                                !email.contains("@")) {
                              return 'enter correct email';
                            }
                          },
                        ),
                        CustomTextField(
                          hintText: "Enter Children Email",
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
                              return 'enter correct children email';
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
                          isPassword: isPasswordShown,
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
                                  isPasswordShown = !isPasswordShown;
                                });
                              },
                              icon: isPasswordShown
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
        ),
      ),
    );
  }
}
