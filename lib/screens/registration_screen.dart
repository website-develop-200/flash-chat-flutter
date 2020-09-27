import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/screens/Button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String password;
  String email;
  bool _saving = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'flashSign',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: kDefaultInpuDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration: kDefaultInpuDecoration.copyWith(
                    hintText: 'Enter the Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              SelectButton(
                  textField: 'Register',
                  onTap: () async {
                    setState(() {
                      _saving = true;
                    });
                    print("The Email id us for registration is $email");
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      print(user);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        _saving = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  colour: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
