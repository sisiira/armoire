import 'package:arm/pages/listevetements.dart';
import 'package:arm/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:arm/pages/Weather.dart';
import 'package:arm/pages/navbar.dart';
import 'package:arm/pages/image_caroussel.dart';

class Homef extends StatefulWidget {
  @override
  State<Homef> createState() => _HomefState();
}

class _HomefState extends State<Homef> {



  @override
  Widget build(BuildContext context) {
    return Column(

        children: [
          Align(

            alignment: Alignment.topCenter, //
            child: Container(

              height: 30,
              child: weather(),
            ),

          ),
          SizedBox(height: 15),
          Text(
            'Je veux une tenue pour...',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            'Choisissez l\'occasion qui convient le mieux à votre journée.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 15),
          Container(

            child : ImageCarousel(),

          ),
        ],
      );
  }
}