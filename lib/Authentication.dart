import 'package:demo1/HomePage.dart';
import 'package:demo1/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthenticationScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   if(_auth.currentUser!=null)
   {
     return HomePage();
   }
   else{
     return LoginScreen();
   }
  }
}