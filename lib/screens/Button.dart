import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  SelectButton({this.textField, this.onTap, this.colour});

  final String textField;
  final Function onTap;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onTap,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            textField,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
