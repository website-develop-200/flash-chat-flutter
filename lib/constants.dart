import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kDefaultBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);
const kcontentPadding = EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
const kFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const InputDecoration kDefaultInpuDecoration = InputDecoration(
  hintText: 'Enter the details here',
  contentPadding: kcontentPadding,
  border: kDefaultBorder,
  enabledBorder: kEnabledBorder,
  focusedBorder: kFocusedBorder,
);
