import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'Button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation animationColor;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    animationColor =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animationColor.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'flashSign',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 60.0,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            SelectButton(
                textField: 'Log In',
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                colour: Colors.lightBlueAccent),
            SelectButton(
                textField: 'Register',
                onTap: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                colour: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
