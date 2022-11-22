import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/mobile/screens/m_add_post_screen.dart';
import 'package:insta_clone/mobile/screens/m_feed_screen.dart';
import 'package:insta_clone/mobile/screens/m_profile_screen.dart';
import 'package:insta_clone/mobile/screens/m_search_screen.dart';
import 'package:insta_clone/utils/colours.dart';


class MHomeScreen extends StatefulWidget {
  static const routeName='/m-home-screen';
  const MHomeScreen({Key? key}) : super(key: key);

  @override
  State<MHomeScreen> createState() => _MHomeScreenState();
}

class _MHomeScreenState extends State<MHomeScreen> {

  int _currentIndex=0;

  final _tabs=[
    MFeedScreen(),
    MSearchScreen(),
    MAddPostScreen(),
    Center(child: Text("Favorites"),),
    MProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "")
        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),
    );
  }
}
