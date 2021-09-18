import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _messageController = TextEditingController();
  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseFirestore.instance
        .collection('-- our user collection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    FirebaseFirestore.instance.collection(' -- Our chat collection -- ').add({
      'text': _enteredMessage,
      //For orderering purpose we create a createdAt field
      'createdAt': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'username': user['username']
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Send message'),
              onChanged: (input) {
                setState(() {
                  _enteredMessage = input;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
