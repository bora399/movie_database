import 'package:flutter/material.dart';
import 'home_page.dart';


showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Are You Sure?"),
    content: Text("Do you want to go back?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}