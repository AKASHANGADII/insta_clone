import 'package:flutter/material.dart';

class User{
  String userName;
  String uid;
  String email;
  String bio;
  List following;
  List followers;
  String imageUrl;
  User({required this.userName,required this.email,required this.uid,required this.bio,required this.imageUrl,required this.followers,required this.following});

  Map<String,dynamic> toJson()=>{
    'userName':userName,
    'bio':bio,
    'email':email,
    'uid':uid,
    'following':[],
    'followers':[],
    'profileImage':imageUrl,
  };
}