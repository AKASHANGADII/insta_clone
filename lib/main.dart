import 'package:flutter/material.dart';
import 'package:insta_clone/mobile/screens/m_login_screen.dart';
import 'package:insta_clone/mobile/screens/m_signup_screen.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
import 'package:insta_clone/responsive/responsive_layout.dart';
import 'package:insta_clone/responsive/web_screen_layout.dart';
import 'package:insta_clone/utils/colours.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(),webScreenLayout: WebScreenLayout(),),
        routes: {
          MLoginScreen.routeName:(ctx)=>MLoginScreen(),
          MSignUpScreen.routeName:(ctx)=>MSignUpScreen(),
        },
      );
    }
}

