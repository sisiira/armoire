import 'package:arm/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'login.dart';

class emailverif extends StatefulWidget {
  const emailverif({super.key});

  @override
  State<emailverif> createState() => _emailverifState();
}

class _emailverifState extends State<emailverif> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            margin: EdgeInsets.fromLTRB(35, 0, 30, 0),
            child: Text('Please verify your email',
              style: TextStyle(fontSize: 40,
                              color: Colors.white),

            ),
          ),
          Divider(
            thickness: 2,
            height: 30,
            indent: 20,
            endIndent: 20,
            color: Colors.white,
          )
            ,
          TextButton(
               onPressed:() async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              } ,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 5,
                      color: Colors.white,
                               ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('send email',style: TextStyle(color: Colors.white),),
                  )
              )
          ),
            Container(
              margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
              child: Row(
                children: [
                  Text('To change account',
                  style: TextStyle(color: Colors.white)),
                     TextButton(onPressed: (){
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                           SignInScreen()), (Route<dynamic> route) => false);
                     },
                        child: Text('Click here',
                          style: TextStyle(color: Colors.white,
                            decoration:TextDecoration.underline
                          ),
                        )
                     ),
                ],),
            )

        ],),

      ),
    );

  }
}