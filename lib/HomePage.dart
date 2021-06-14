
import 'package:demo1/FB.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  // HomePage({required uid});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
appBar:AppBar(title: Text('HOME'),
actions: [
IconButton(icon: Icon(Icons.logout,color: Colors.white,), onPressed: () =>logOut(context),),
],),
  
     
      
    );
  }
}