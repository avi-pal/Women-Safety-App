import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/child/bottom_page.dart';
import 'package:women_safety_app/db/share_pref.dart';
import 'package:women_safety_app/child/bottom_screens/child_home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/child/child_login_screen.dart';
import 'package:women_safety_app/parent/parent_home_screen.dart';
import 'package:women_safety_app/utils/constants.dart';
import 'package:women_safety_app/widgets/home_widgets/safewebview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: MySharedPreference.getUserType(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == "") {
                return LoginScreen();
              }
              if (snapshot.data == "child") {
                return BottomPage();
              }
              if (snapshot.data == "parent") {
                return ParentHomeScreen();
              }
              return progressIndicator(context);
            }) //home: webv(),
        );
  }
}

// class webv extends StatefulWidget {
//   const webv({super.key});

//   @override
//   State<webv> createState() => _webvState();
// }

// class _webvState extends State<webv> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SafeWebView(),
//                   ),
//                 );
//               },
//               child: Text("Click me daddy!!"))),
//     );
//   }
// }
// class CheckAuth extends StatelessWidget {

//   checkData(){

//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(

//     );
//   }
// }

