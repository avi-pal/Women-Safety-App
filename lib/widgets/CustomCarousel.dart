import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:women_safety_app/utils/quotes.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 2.0, autoPlay: true, enlargeCenterPage: true),
        items: List.generate(
          imageSliders.length,
          (index) => Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageSliders[index]),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ])),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                    child: Text(
                      articleTitle[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
