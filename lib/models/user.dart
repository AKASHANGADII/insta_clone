import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userName;
  String uid;
  String email;
  String bio;
  List following;
  List followers;
  String imageUrl;
  User(
      {required this.userName,
      required this.email,
      required this.uid,
      required this.bio,
      required this.imageUrl,
      required this.followers,
      required this.following});


  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        userName: snapshot['userName'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        bio: snapshot['bio'],
        imageUrl: snapshot['profileImage'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'bio': bio,
        'email': email,
        'uid': uid,
        'following': [],
        'followers': [],
        'profileImage': imageUrl,
      };


}
