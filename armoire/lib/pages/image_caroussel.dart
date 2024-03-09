import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/Beach.png',
    'assets/Casual.png',
    'assets/Office.png',
    'assets/Sport.png',
    'assets/Travel.png',
  ];

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: 400,

      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      children: imagePaths.map((path) {
        return Image.asset(
          path,
          fit: BoxFit.contain,
        );
      }).toList(),
      onPageChanged: (value) {
        // Hna l code dial meni twerek bach idik l outfit
      },
      autoPlayInterval: 3000,
    );
  }
}