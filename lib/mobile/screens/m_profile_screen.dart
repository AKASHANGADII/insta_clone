import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colours.dart';
import 'package:insta_clone/utils/utils.dart';

import '../widgets/follow_button.dart';

class MProfileScreen extends StatefulWidget {
  final String uid;

  MProfileScreen({super.key, required this.uid});

  @override
  State<MProfileScreen> createState() => _MProfileScreenState();
}

class _MProfileScreenState extends State<MProfileScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isFollowing = false;
  var userData = {};
  int followers = 0;
  int posts = 0;
  int following = 0;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading=true;
    });
    try {

      var userSnap = await _firestore.collection('users').doc(widget.uid).get();
      userData = userSnap.data()!;

      var postSnap = await _firestore
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      posts = postSnap.docs.length;

      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;

      isFollowing=userData['following'].contains(widget.uid);
      setState(() {});

    } catch (err) {
      showSnackBar(context, err.toString());
    }
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?Center(child: CircularProgressIndicator(),):Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(userData['userName']),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: 46,
                      child: CircleAvatar(
                        radius: 44,
                        backgroundImage: NetworkImage(
                            userData['profileImage']),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProfileStatColumn(
                                  num: posts,
                                  data: "Posts",
                                ),
                                ProfileStatColumn(
                                  num: followers,
                                  data: "Followers",
                                ),
                                ProfileStatColumn(
                                  num: following,
                                  data: "Following",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? FollowButton(
                                    text: "Edit profile",
                                    backgroundColor: Colors.transparent,
                                    borderColor: Colors.grey,
                                    textColor: Colors.grey,
                                  )
                                : isFollowing
                                    ? FollowButton(
                                        text: "Unfollow",
                                        backgroundColor: Colors.white,
                                        borderColor: Colors.white,
                                        textColor: Colors.black,
                                      )
                                    : FollowButton(
                                        text: "Follow",
                                        backgroundColor: Colors.blue,
                                        borderColor: Colors.blue,
                                        textColor: Colors.white),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 14),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userData['userName'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userData['bio'],
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade800,
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _firestore
                .collection('posts')
                .where('uid', isEqualTo: widget.uid)
                .get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 3,
                    crossAxisSpacing:3),
                itemBuilder: (context, index) => GridTile(
                  child: Image.network(snapshot.data!.docs[index]['postUrl'],fit: BoxFit.cover,),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

class ProfileStatColumn extends StatelessWidget {
  final String data;
  final int num;
  ProfileStatColumn({required this.data, required this.num});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          data,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}