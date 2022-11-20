import 'package:flutter/material.dart';

class Comments{
  final String userName;
  final String uid;
  final String profileUrl;
  final String commentText;
  final DateTime dateTime;
  final String commentId;

  Comments({required this.userName,required this.uid,required this.profileUrl,required this.commentText,required this.dateTime,required this.commentId});

  Map<String,dynamic> toJson()=>{
    'userName':userName,
    "uid":uid,
    "profileUrl":profileUrl,
    "commentText":commentText,
    "dateTime":dateTime,
    "commentId":commentId,
  };
}