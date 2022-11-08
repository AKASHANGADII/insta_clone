import 'package:flutter/material.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class MHomeScreen extends StatelessWidget {
  static const routeName='/m-home-screen';
  const MHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? userDetails=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text(userDetails!.email),),
    );
  }
}
