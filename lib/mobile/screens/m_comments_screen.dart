import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/mobile/widgets/comment_card.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/colours.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class MCommentsScreen extends StatefulWidget {
  static const routeName = '/m-comments-screen';

  @override
  State<MCommentsScreen> createState() => _MCommentsScreenState();
}

class _MCommentsScreenState extends State<MCommentsScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    List postData = ModalRoute.of(context)!.settings.arguments as List;
    String postId = postData[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        title: Text("comments"),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .orderBy('dateTime', descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => CommentCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                ));
              }
            },
          )),
          Container(
            margin:const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.09,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(user!.imageUrl),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: "Comment as @${user!.userName}",
                          hintStyle: const TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  commentController.text.isNotEmpty
                      ? InkWell(
                          onTap: () async {
                            await FirestoreMethods().postComment(
                                postId.toString(),
                                user.userName,
                                user.uid,
                                commentController.text,
                                DateTime.now(),
                                user.imageUrl);
                            commentController.clear();
                          },
                          child: const Text(
                            "Post",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      : Text(
                          "Post",
                          style: TextStyle(color: Colors.blue.withOpacity(0.4)),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
