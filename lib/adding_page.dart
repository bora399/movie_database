import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'alert_message.dart';

class AddingPage extends StatefulWidget {
  const AddingPage({Key? key}) : super(key: key);

  @override
  State<AddingPage> createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    CollectionReference movieRef = _firestore.collection("movieref");
    var babaRef = movieRef.doc("Baba");

    return Scaffold(
      appBar:AppBar(
        title:Text("Adding Movies To Database"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor:Colors.black54,
        leading:IconButton(
          onPressed:(){
            showAlertDialog(context);
          },
          icon:Icon(Icons.arrow_back),
        ),
      ),
      body:Container(
        child:Column(
          children:[
            Card(
              child:TextFormField(
                controller:nameController,
                autofocus: true,
                decoration:InputDecoration(
                  hintText:'What is the name of the movie?'
                ),
              ),
            ),
            Card(
              child:TextFormField(
                controller:dateController,
                autofocus: true,
                decoration:InputDecoration(
                    hintText:"What is the release date of the movie you've typed?"
                ),
              ),
            ),
            ElevatedButton(
              onPressed:()async{
                Map<String,dynamic> data = {
                  'name':nameController.text,
                  'date':dateController.text,
                };
                await movieRef.doc(nameController.text).set(data);
                nameController.text = '';
                dateController.text = '';
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child:Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
