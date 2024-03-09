import 'package:arm/pages/Weather.dart';
import 'package:arm/pages/ajouter.dart';
import 'package:arm/pages/image_caroussel.dart';
import 'package:arm/pages/item_details.dart';
import 'package:arm/pages/listevetements.dart';
import 'package:arm/pages/login.dart';
import 'package:arm/pages/navbar.dart';
import 'package:arm/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:arm/main.dart';

import 'home.dart';


class MyRoutes{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    String arg=settings.arguments.toString();
    switch(settings.name){
      case'/': return MaterialPageRoute(builder: (context)=>homepage());
      case'/login/': return MaterialPageRoute(builder: (context)=>SignInScreen());
      case'/register/': return MaterialPageRoute(builder: (context)=>SignUpScreen());
      case'/home': return MaterialPageRoute(builder: (context)=>Home());
      case'/listevetements': return MaterialPageRoute(builder: (context)=>ItemList());
      case'/itemdetails': return MaterialPageRoute(builder: (context)=>ItemDetails(arg));
      case'/ajouter': return MaterialPageRoute(builder: (context)=>MyForm());
      case'/weather': return MaterialPageRoute(builder: (context)=>weather());
      case'/image': return MaterialPageRoute(builder: (context)=>ImageCarousel());
      case'/navbar': return MaterialPageRoute(builder: (context)=>Navbar());
      
    }
    return MaterialPageRoute(builder: (_){
      return Text('error');
    });
  }

}