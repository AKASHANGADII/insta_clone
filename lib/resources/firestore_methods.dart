import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/comments.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String> UploadPost(String description, Uint8List image, String uid,
      String userName, String profileUrl) async {
    String res = "Something went wrong";
    try {
      String _postUrl =
          await StorageMethods().uploadImageToStorage("posts", image, true);
      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          userName: userName,
          datePublished: DateTime.now(),
          postId: postId,
          postUrl: _postUrl,
          profileImage: profileUrl,
          likes: []);
      await _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String uid, String postId, List likes) async {
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<String> postComment(String postId, String userName, String uid,
      String text, DateTime date, String profileUrl) async {
    try {
      if (text.isNotEmpty) {
        var commentId = const Uuid().v1();
        Comments comment = Comments(
            userName: userName,
            uid: uid,
            profileUrl: profileUrl,
            commentText: text,
            dateTime: DateTime.now(),
            commentId: commentId);
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toJson());
      }
    } catch (err) {
      return err.toString();
    }
    return "something";
  }

  Future<void> followUser(String followId) async {
    String uid=await FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snap=await _firestore.collection('users').doc(uid).get();
    List following=(snap.data() as dynamic)['following'];
    if(following.contains(followId)){
      await _firestore.collection('users').doc(uid).update({'following':FieldValue.arrayRemove([followId])});
      await _firestore.collection('users').doc(followId).update({"followers":FieldValue.arrayRemove([uid])});
    }
    else{
      await _firestore.collection('users').doc(uid).update({"following":FieldValue.arrayUnion([followId])});
      await _firestore.collection('users').doc(followId).update({"followers":FieldValue.arrayUnion([uid])});
    }
  }
}
