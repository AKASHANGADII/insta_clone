import 'package:flutter/material.dart';

class MHomeScreen extends StatelessWidget {
  static const routeName='/m-home-screen';
  const MHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("HomeScreen"),),
    );
  }
}
