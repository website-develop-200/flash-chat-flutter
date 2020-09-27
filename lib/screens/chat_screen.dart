import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final db = FirebaseFirestore.instance.collection('messages');

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  String chatUser;
  String prevoiusValue;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() {
    User user = _auth.currentUser;
    if (user != null) {
      chatUser = user.email;
      print(chatUser);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  String chatValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: db.snapshots(),
                builder: (context, snapshots) {
                  List<MessageBubble> messageList = [];
                  if (!snapshots.hasData) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "No Messages found",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                  final msg = snapshots.data.docs.reversed;
                  for (var document in msg) {
                    String text = document.data()["text"];
                    String sender = document.data()["Messaged By"];
                    Timestamp time = document.data()["time"];
                    messageList.add(MessageBubble(
                        text: text,
                        sender: sender,
                        time: time,
                        isMe: chatUser == sender));
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: messageList,
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        chatValue = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (prevoiusValue != chatValue) {
                        if (chatValue.isNotEmpty && chatValue != "") {
                          db.add({
                            'Messaged By': chatUser,
                            'text': chatValue,
                            'time': DateTime.now(),
                          });
                        }
                      }
                      prevoiusValue = chatValue;
                      textController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.time, this.isMe});
  String text;
  String sender;
  Timestamp time;
  bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(color: Colors.black54),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(30.0) : Radius.circular(0),
                topRight: isMe ? Radius.circular(0) : Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            color: isMe ? Colors.blue : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
          Text(
            timeGenerator(time),
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

String timeGenerator(Timestamp time) {
  return DateFormat.jm().format(time.toDate()).toString();
}
