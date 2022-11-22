import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart' as model;
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/storage_methods.dart';

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User curUser=_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(curUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser(String userName,String email,String password,String bio,Uint8List image) async {
    String res="Something went wrong";
    try{
      if(userName.isNotEmpty||password.isNotEmpty||email.isNotEmpty||bio.isNotEmpty||image!=Null){
        UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl=await StorageMethods().uploadImageToStorage("profilePics", image, false);

        model.User user=model.User(userName: userName,bio: bio,email: email,uid: cred.user!.uid,imageUrl: downloadUrl,followers: [],following: []);
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        res="Successfully created";
      }

    }
    // on FirebaseAuthException catch(err){
    //   if(err.code=='invalid-email'){
    //     res="Email is badly formated";
    //   }
    //   else if(err.code=='weak-password'){
    //     res="The password is weak";
    //   }
    // }
    catch(err){
      res=err.toString();
    }
    return res;
  }


  Future<String> loginUser(String email,String password) async{
    String res="Something went wrong!";
    try {
      if(email.isNotEmpty||password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      }
    }catch(err){
      res=err.toString();
    }
    return res;
  }


  Future<void> logOut() async{
    await _auth.signOut();
  }


}