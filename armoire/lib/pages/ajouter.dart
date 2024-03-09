

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String? _type='';
  String? _color='';
  String? _occasion='';
  final user=FirebaseAuth.instance.currentUser?.email;
  String imageUrl='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Clothes'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  decoration: InputDecoration(
                    labelText: 'input',
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Please enter a type';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _type = value;
                  },
                ),
                const SizedBox(
                  height: 9,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  decoration: InputDecoration(
                    labelText: 'color',
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Please enter a color';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _color = value;
                  },
                ),
                const SizedBox(
                  height: 9,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  decoration: InputDecoration(
                    labelText: 'occasion',
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Please enter an occasion';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _occasion = value;
                  },
                ),
                SizedBox(height: 8.0),
                IconButton(onPressed: () async{

                  ImagePicker imagePicker=ImagePicker();
                  XFile? file=await imagePicker.pickImage(source: ImageSource.camera );
                  print(file?.path);
                  if(file?.path==null) return;
                  String filename=DateTime.now().microsecondsSinceEpoch.toString();
                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDir=referenceRoot.child('images');
                  Reference referenceuploadimage=referenceDir.child(filename);
                 try{
                   await referenceuploadimage.putFile(File(file!.path));
                   imageUrl=await referenceuploadimage.getDownloadURL();
                   ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('image uploaded'),));

                 }catch(e){
                     print(e.toString());
                 }



                }, icon: Icon(Icons.camera_alt)),
                SizedBox(height: 7,),
                ElevatedButton(
                  onPressed: () {
                    if(imageUrl.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('please upload an image'),));
                      return;
                    }
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                     Createvete(
                         color: _color.toString(),
                         type: _type.toString(),
                         occasion: _occasion.toString(),
                         image: imageUrl,
                     );
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey;
                        }
                        return Colors.purple;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                ),

              ],
            ),
          ),
        ),
      );

  }
  Future Createvete({required String color ,required String type ,required String occasion,required String image}) async{
    String docname=DateTime.now().microsecondsSinceEpoch.toString();
    final docvet = FirebaseFirestore.instance.collection('vetements').doc(docname);
    final data={
      'couleur': color,
      'email':user,
      'type':type,
      'occasion':occasion,
      'image':image,
      'id':docname,
    };
    await docvet.set(data);

  }
}


