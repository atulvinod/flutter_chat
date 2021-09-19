import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebasetut/widgets/chat_messages.dart';
import 'package:firebasetut/widgets/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                  // Value is the unique identifier to determine which item was pressed in onChanged
                  value: 'logout',
                  child: Container(
                    width: 100,
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        Spacer(),
                        Text('Logout'),
                      ],
                    ),
                  ))
            ],
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onChanged: (itemIdentifier) {
              //To signout the user using the firebase auth
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      // As the firebase instance gives us a stream of data to listen to,
      // we can use the StreamBuilder widget to listen to the steam data
      // and update the widget accordingly.
      body: Container(
        child: Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // We can add data using the .add function of the CloudFirestore
      //     FirebaseFirestore.instance.collection('-- Collection Url').add({});
      //   },
      // ),
    );
  }
}
