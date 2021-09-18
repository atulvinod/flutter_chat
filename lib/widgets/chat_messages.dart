import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetut/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('-- Collection Path -- eg: chats')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final documents = streamSnapshot.data!.documents;
          return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, index) => MessageBubble(
                    documents[index]['text'],
                    documents[index]['username'],
                    FirebaseAuth.instance.currentUser!.uid ==
                        documents[index]['userId'],
                    // To optimise the build of the listview builder
                    key: ValueKey(documents[index].documentID),
                  ));
        });
  }
}
