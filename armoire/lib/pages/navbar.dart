import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:ListView(
          children: [
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('À propos de nous'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('À propos de nous'),
                      content: Text('Notre application web mobile vise à aider les utilisateurs à trouver le parfait outfit pour chaque occasion. Que ce soit pour un mariage, une soirée entre amis ou une réunion professionnelle, notre application offre des suggestions personnalisées en fonction des goûts et des préférences de chaque individu. Grâce à une interface conviviale et intuitive, les utilisateurs peuvent facilement naviguer à travers une large gamme de vêtements, d\'accessoires et de styles pour trouver l\'ensemble qui correspond le mieux à leur personnalité et à l\'événement.'),
                      actions: [
                        ElevatedButton(
                          child: Text('Fermer'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              leading:Icon(Icons.phone_callback),
              title: Text('contacter nous'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(

                      title: Text('Nos contacts'),
                      content: Text('email: Ayoubben1430@gmail.com Num: 076889208 '),
                      actions: [
                        ElevatedButton(
                          child: Text('Fermer'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            Divider(),
            ListTile(
              leading:Icon(Icons.logout),
              title: Text('Deconnexion'),
              onTap: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    SignInScreen()), (Route<dynamic> route) => false);},
            ),

          ],
        )
    );
  }
}