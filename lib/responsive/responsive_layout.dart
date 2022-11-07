import 'package:flutter/material.dart';
import 'package:insta_clone/mobile/screens/m_home_screen.dart';
import 'package:insta_clone/mobile/screens/m_login_screen.dart';
import 'package:insta_clone/utils/responsiveness.dart';

class ResponsiveLayout extends StatelessWidget {
  Widget mobileScreenLayout;
  Widget webScreenLayout;
  ResponsiveLayout({required this.mobileScreenLayout,required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth>minWebScreenSize){
          return webScreenLayout;
      }
      //TODO:MLOginScreen to be passed
      return MHomeScreen();
    });
  }
}
