import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userId;
  final bool isSelf;
  const MessageBubble(this.message, this.userId, this.isSelf, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We wrap the container with row so that the ListView respects the width of the container
    return Row(
      mainAxisAlignment:
          isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: isSelf ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(12)),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment:
                isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('-- our users collection -- ')
                    .doc(userId)
                    .get(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Text(
                    snapshot.data['username'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelf ? Colors.black : Colors.red),
                  );
                },
              ),
              Text(
                message,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
