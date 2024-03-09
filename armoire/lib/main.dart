
import 'package:arm/pages/ajouter.dart';
import 'package:arm/pages/item_details.dart';
import 'package:arm/pages/routes.dart';
import 'package:arm/pages/verif.dart';
import 'package:flutter/material.dart';
import 'package:arm/pages/home.dart';
import 'package:arm/pages/listevetements.dart';
import 'package:arm/pages/register.dart';
import 'package:arm/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arm/firebase_options.dart';
import 'package:arm/pages/item_details.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: homepage(),
   /* routes: {
      '/login/':(context)=> SignInScreen(),
      '/register/':(context)=>SignUpScreen(),
      '/home':(context)=>home(),
      '/listevetements':(context)=>ItemList(),
      '/ajouter':(context)=>MyForm(),
       //'/item_details' :(context)=>ItemDetails(),
    },*/
    onGenerateRoute: MyRoutes.generateRoute,

  ));
}
class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder:(context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if(user != null){
                 if(user.emailVerified){
                   print('email verified');}
                  else {
                    print(user);
                    return const emailverif(); }
                               }
              else{
                return SignInScreen();
              }
             return Home();

            default:
              return const CircularProgressIndicator();
          }
        }




    );
  }
}

