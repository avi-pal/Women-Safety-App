import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:women_safety_app/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  //const CustomAppBar({super.key});
  Function onTap;
  int quoteIndex;
  CustomAppBar({ required this.onTap,required this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        onTap(),
      },
      child: Container(
        child: Text(
          sweetSayings[quoteIndex!],
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
