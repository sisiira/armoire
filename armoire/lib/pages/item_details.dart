import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails( this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('vetements').doc(itemId);
    _futureData = _reference.get();
  }


  String itemId;
  late DocumentReference _reference;

  //_reference.get()  --> returns Future<DocumentSnapshot>
  //_reference.snapshots() --> Stream<DocumentSnapshot>
  late Future<DocumentSnapshot> _futureData;
  late Map data;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item details'),
        actions: [
          IconButton(
              onPressed: () {
                //add the id to the map
                data['id'] = itemId;

              },
              icon: Icon(Icons.edit)),
          IconButton(onPressed: (){
            //Delete the item
            _reference.delete();
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            //Get the data
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            //display the data
            return Center(
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(border:Border.all(color: Colors.purple,width: 1),
                borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Item Details'),
                    Container(
                    decoration: BoxDecoration(border: Border.all(color:Colors.black,width: 1)),
                    child:data.containsKey('image') ? Image
                      .network(
                    '${data['image']}',height: 200,width: 200,) : Container(), ),
                    SizedBox(height: 10,),
                    Text('Couleur:  ${data['couleur']}',style: TextStyle(fontSize: 20),),
                    Text('Occasion:  ${data['occasion']}',style: TextStyle(fontSize: 20),),
                    Text('Type:   ${data['type']}',style: TextStyle(fontSize: 20),)


                  ],
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}