import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'adding_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference movieRef = _firestore.collection("movieref");
    var babaRef = movieRef.doc("Baba");

    return Scaffold(
      appBar: AppBar(
        title:Text("Welcome To My Movie Database!"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:Colors.black54,
      ),
      body:Container(
        child:Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:movieRef.snapshots(),
              builder:(BuildContext context,AsyncSnapshot asyncSnapshot){
                if (!asyncSnapshot.hasData) {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }
                List<DocumentSnapshot> listOfDocumentSnapshot = asyncSnapshot.data.docs;
                return Flexible(
                  child: ListView.builder(

                    itemCount:listOfDocumentSnapshot.length,
                    itemBuilder:(context,index){
                        return Dismissible(
                          background:Container(
                            color:Colors.red,
                            child:Icon(Icons.delete),
                          ),
                          key:ObjectKey(listOfDocumentSnapshot[index]),
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            setState((){
                              listOfDocumentSnapshot[index].reference.delete();
                            });
                            // Then show a snackbar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('item dismissed')));
                          },
                          child: Card(
                            color:Colors.black12,
                              child: ListTile(
                                  title: Text('${listOfDocumentSnapshot[index].get('name')}',style:TextStyle(fontSize:24)),
                                  subtitle:Text('${listOfDocumentSnapshot[index].get('date')}',style:TextStyle(fontSize:18)),
                              ),
                          ),
                        );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddingPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}