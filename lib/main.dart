import 'package:flutter/material.dart';
import 'package:women_safety_app/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/widgets/home_widgets/safewebview.dart';

void main() {
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
      home: HomeScreen(),
      //home: webv(),
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
