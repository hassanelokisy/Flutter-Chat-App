import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
          builder:(ctx , snapshpt){
            if(snapshpt.connectionState== ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            
          } return StreamBuilder(
        stream: Firestore.instance
            .collection("chat")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshpt) {
          if (chatSnapshpt.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshpt.data.documents;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (BuildContext context, int index) {
              return MessageBubble(
                chatDocs[index]["text"],
                chatDocs[index]["username"],
                chatDocs[index]["userIamge"],
                snapshpt.data.uid == chatDocs[index]["userId"] ,
                key: ValueKey(chatDocs[index].documentID) ,
              );
            },
          );
        },
      );
      }
    );
  }
}
