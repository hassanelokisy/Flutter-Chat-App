import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this._isMe, {
    this.key,
  });
  final message;
  final String username;
  final String userImage;
  final bool _isMe;
  Key key;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: _isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: !_isMe ? Radius.circular(0) : Radius.circular(18),
                  bottomRight: _isMe ? Radius.circular(0) : Radius.circular(18),
                ),
              ),
             
              width: MediaQuery.of(context).size.width * .65,
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 16,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isMe ? Colors.black : Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    message,
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(color: _isMe ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -5,
          left: _isMe ? null : MediaQuery.of(context).size.width * .65 -20,
          right: _isMe ? MediaQuery.of(context).size.width * .65 - 20 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImage,
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
