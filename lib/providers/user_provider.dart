import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  User? get getUser=>_user;
  Future<void> refreshUser()async {
    _user=await AuthMethods().getUserDetails();
    print(_user!.imageUrl);
    notifyListeners();
  }
}