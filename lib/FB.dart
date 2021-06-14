import 'package:demo1/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final DBRef = FirebaseDatabase.instance.reference().child('User');

Future createAccount(
    String email, String password, String mobile, BuildContext context) async {
  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print('Register Succesfully');

      DBRef.child(user.uid)
          .set({"email": email, "password": password, "mobile": mobile});
      return user;
    } else {
      print("Account Falied");
      return user;
    }
  } catch (e) {
    print(e);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Container(
                height: 150,
                child: Column(
                  children: [
                    Container(
                        height: 120,
                        child: Text(
                          '$e',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK')),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
    return null;
  }
}

Future login(String email, String password, BuildContext context) async {
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print('Login Succesfully');
      return user;
    } else {
      print("Login Falied");
      return user;
    }
  }on  FirebaseAuthException  catch (e) {
    print(e);
    debugPrint(e.toString());
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Container(
                height: 150,
                child: Column(
                  children: [
                    Container(
                        height: 120,
                        child: Text(
                          '${e.message}',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK')),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
    return null;
  }
}

Future logOut(BuildContext context) async {
  try {
    await _auth.signOut().then((user) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    });
  } catch (e) {
    print("error" + e.toString());
  }
}
