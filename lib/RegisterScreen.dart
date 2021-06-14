import 'package:demo1/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'FB.dart';
import 'loginScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordeController = TextEditingController();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(
              child: Text(
            'REGISTER',
            style: TextStyle(color: Colors.white, fontSize: 22),
          )),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 5),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),

                    // ignore: missing_return
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid Email.';
                      }
                      if (value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 5),
                  child: TextFormField(
                    controller: mobileController,
                    decoration: InputDecoration(labelText: 'Mobile No'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a mobile no.';
                      } else if (value.length != 10) {
                        return 'Mobile Number must be of 10 digit';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 5),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.length < 6)
                        return 'Passord must be more than 6 charater';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 5),
                  child: TextFormField(
                    controller: confirmPasswordeController,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.length < 6)
                        return 'Confirm Passord must be more than 6 charater';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child:isLoading?CircularProgressIndicator(): Container(
                      height: 45,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if (_globalKey.currentState!.validate()) {

                            setState(() {
                              isLoading=true;
                            });
                            createAccount(emailController.text.toString(),passwordController.text.toString(),mobileController.text,context).then((user){
                              if(user!=null)
                              {
                                setState(() {
                                  isLoading=false;
                                });
                                print("Account Sucessfull Create");
                                 Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomePage()),
                                        (route) => false);
                              }
                              else{
                                print('Register Failed');
                                setState(() {
                                      isLoading = false;
                                    });
                              }
                            });
                            // createAccount();

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text('Processing Data....')));
                          }
                        },
                        child:isLoading?CircularProgressIndicator(): Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                      text: TextSpan(
                          text: 'Do you have an account?',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: ' Login',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen()),
                                    (route) => false);
                              }),
                      ])),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
