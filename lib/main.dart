import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/mobile/screens/m_comments_screen.dart';
import 'package:insta_clone/mobile/screens/m_home_screen.dart';
import 'package:insta_clone/mobile/screens/m_login_screen.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
import 'package:insta_clone/responsive/responsive_layout.dart';
import 'package:insta_clone/responsive/web_screen_layout.dart';
import 'package:insta_clone/utils/colours.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'mobile/screens/m_signup_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>UserProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.active){
                if(snapshot.hasData){
                  return ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(),webScreenLayout: WebScreenLayout());
                }
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator(color: primaryColor,);
              }
              return MLoginScreen();
            },
          ),
          routes: {
            MLoginScreen.routeName:(ctx)=>MLoginScreen(),
            MSignUpScreen.routeName:(ctx)=>MSignUpScreen(),
            MHomeScreen.routeName:(ctx)=>MHomeScreen(),
            MCommentsScreen.routeName:(ctx)=>MCommentsScreen(),
          },
        ),
      );
    }
}

