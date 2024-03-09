import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../pages/item_details.dart';
import '../utils/color_utils.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 170,
    height: 170,
    color: Colors.white,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}


Container Customcard(BuildContext context,Map<dynamic,dynamic> item){
 return Container(
   child: Card(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15.0),
     ),
     color: Colors.grey,
     elevation: 10,
     child:
         Container(
           width: 160,
           padding: EdgeInsets.only(top: 15),
           child: ListTile(
             contentPadding: EdgeInsets.only(left: 5),
             leading: item.containsKey('image') ? Image
                 .network(
                 '${item['image']}',height: 70,width: 70,) : Container(),
             title: Text('${item['type']}'),
             subtitle: Text('${item['occasion']}'),
             onTap:(){
               Navigator.of(context).pushNamed('/itemdetails',arguments: item['id'].toString());
               },
           ),
         ),

         ),
 );


}