
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'Hero',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email=value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Email')
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password=value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: ()async {
                    setState(() {
                      showSpinner=true;
                    });
                      try {
                      final NewUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(NewUser !=null)
                      {
                      Navigator.pushNamed(context, ChatScreen.id);
                      }

                      setState(() {
                        showSpinner=false;
                      });

                      }catch(e){print(e);
                      }},
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Registration',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
              ],
            ),
          ),inAsyncCall: showSpinner,
        ),
      ),
    );
  }
}

