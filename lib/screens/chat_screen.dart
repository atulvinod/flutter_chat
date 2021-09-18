import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // As the firebase instance gives us a stream of data to listen to,
      // we can use the StreamBuilder widget to listen to the steam data
      // and update the widget accordingly.
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('-- Collection Path -- ')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final documents = streamSnapshot.data!.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) =>
                  streamSnapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : Container(
                          padding: EdgeInsets.all(10),
                        ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // We can add data using the .add function of the CloudFirestore
          FirebaseFirestore.instance.collection('-- Collection Url').add({});
        },
      ),
    );
  }
}
