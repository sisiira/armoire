import 'package:arm/pages/home.dart';
import 'package:arm/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arm/widgets/reusable_widget.dart';
import 'package:arm/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _NomTextController = TextEditingController();
  TextEditingController _PreNomTextController = TextEditingController();
  TextEditingController _VilleController = TextEditingController();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    reusableTextField(
                        "Entrer votre Nom", Icons.person_outline, false,
                        _NomTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Entrer votre Prenom", Icons.person_outline, false,
                        _PreNomTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Entrer votre Ville", Icons.villa_outlined, false,
                        _VilleController),
                    const SizedBox(
                      height: 20,
                    ),

                    reusableTextField(
                        "Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) async {
                        await Createuser(
                            nom: _NomTextController.text,
                            prenom: _PreNomTextController.text,
                            ville: _VilleController.text,
                            email: _emailTextController.text);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }).onError((error, stackTrace) async {
                        await showerror(context, error.toString());
                      });
                    })
                  ],
                ),
              ))),
    );
  }

  Future Createuser(
      {required String nom, required String prenom, required String ville, required String email}) async {
    final docvet = FirebaseFirestore.instance.collection('users').doc(email);
    final data = {
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'ville': ville,

    };
    await docvet.set(data);
  }

  }

