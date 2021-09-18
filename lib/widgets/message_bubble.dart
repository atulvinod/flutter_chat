import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String imageUrl;
  final bool isSelf;
  const MessageBubble(this.message, this.userName, this.imageUrl, this.isSelf,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We wrap the container with row so that the ListView respects the width of the container
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color:
                      isSelf ? Colors.grey[300] : Theme.of(context).accentColor,
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
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelf ? Colors.black : Colors.red),
                  ),
                  Text(
                    message,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: -10,
            left: isSelf ? null : 120,
            right: isSelf ? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ))
      ],
      clipBehavior: Clip.none,
    );
  }
}
