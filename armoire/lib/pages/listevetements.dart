import 'package:arm/widgets/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:arm/pages/item_details.dart';
import 'package:arm/pages/ajouter.dart';
import 'package:getwidget/getwidget.dart';

class ItemList extends StatelessWidget {
  ItemList({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  final user = FirebaseAuth.instance.currentUser;
  CollectionReference _reference =
  FirebaseFirestore.instance.collection('vetements');

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Items'),
      ),*/
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //Check error
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }

            //Check if data arrived
            if (snapshot.hasData) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //Convert the documents to Maps
              List<Map> itemsT = documents.map((e) => e.data() as Map)
                  .where((element) =>
              element['email'] == user?.email && element['categorie'] == 'top')
                  .toList();
              List<Map> itemsB = documents.map((e) => e.data() as Map)
                  .where((element) =>
              element['email'] == user?.email &&
                  element['categorie'] == 'bottom')
                  .toList();
              List<Map> itemsS = documents.map((e) => e.data() as Map)
                  .where((element) =>
              element['email'] == user?.email &&
                  element['categorie'] == 'shoes')
                  .toList();
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(children: [Text('Top',style: TextStyle(fontSize: 30)),
                      SizedBox(width: 5,),Icon(Icons.next_plan)],),
                    SizedBox(height: 10,),
                    Container(
                      height: 110,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: itemsT.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map thisItem = itemsT[index];
                            return Customcard(context, thisItem);

                          }),
                    ),
                    SizedBox(height: 30,),

                    Row(children: [Text('Bottom',style: TextStyle(fontSize: 30)),
                      SizedBox(width: 5,),Icon(Icons.next_plan)],),
                    SizedBox(height: 10,),
                    Container(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: itemsB.length,
                          itemBuilder: (BuildContext context, int index) {

                            Map thisItem = itemsB[index];
                            return Customcard(context,thisItem);

                          }),
                    ),
                    SizedBox(height: 30,),

                    Row(
                      children: [Text('Shoes',style: TextStyle(fontSize: 30),),
                        SizedBox(width: 5,),
                        Icon(Icons.next_plan)],),
                    SizedBox(height: 10,),
                    Container(
                      height: 110,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: itemsS.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map thisItem = itemsS[index];
                            return Customcard(context, thisItem);
                          }),
                    ),
                  ]
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
      //Show loader


      //Display a list // Add a FutureBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyForm()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}