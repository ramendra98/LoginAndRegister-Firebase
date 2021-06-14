
import 'package:demo1/loginScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Authentication.dart';






void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationScreen(),
    );
  }
}
