import 'package:demo1/FB.dart';
import 'package:demo1/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'LOGIN',
            style: TextStyle(color: Colors.white, fontSize: 22),
          )),
          backgroundColor: Colors.red,
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
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 15),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: ' Email'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.length < 6)
                        return 'Eaiil Id  must be more than 6 charater';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 5),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.length < 6)
                        return 'Passord must be more than 6 charater';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          height: 45,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                login(emailController.text.toString(),
                                        passwordController.text.toString(),context)
                                    .then((user) {
                                  if (user != null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomePage()),
                                        (route) => false);
                                    print('Login Successfully');
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print('Login Failed');
                                  }
                                });
                                // createAccount();

                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text('Processing Data....')));
                              }
                            },
                            child: isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: ' Create New Account',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RegisterScreen()),
                                    (route) => false);
                              }),
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
