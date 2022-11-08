import 'package:flutter/material.dart';
import 'package:insta_clone/mobile/screens/m_home_screen.dart';
import 'package:insta_clone/mobile/screens/m_login_screen.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/responsiveness.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  Widget mobileScreenLayout;
  Widget webScreenLayout;
  ResponsiveLayout({required this.mobileScreenLayout,required this.webScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }
  void addData(){
    Provider.of<UserProvider>(context,listen: false).refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth>minWebScreenSize){
          return widget.webScreenLayout;
      }
      //TODO:MLOginScreen to be passed
      return MHomeScreen();
    });
  }
}
