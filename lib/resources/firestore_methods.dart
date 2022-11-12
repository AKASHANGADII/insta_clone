import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> UploadPost(
      String description,
      Uint8List image,
      String uid,
      String userName,
      String profileUrl
      ) async{
    String res="Something went wrong";
    try{
      String _postUrl=await StorageMethods().uploadImageToStorage("posts", image, true);
      String postId=const Uuid().v1();

      Post post=Post(description: description, uid: uid, userName: userName, datePublished: DateTime.now(), postId: postId, postUrl: _postUrl, profileImage: profileUrl, likes: []);
      await _firestore.collection("posts").doc(postId).set(post.toJson());
      res="success";
    }
    catch(err){
      res=err.toString();
    }
    return res;
  }
}