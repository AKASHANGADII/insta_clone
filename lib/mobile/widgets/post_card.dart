import 'package:flutter/material.dart';
import 'package:insta_clone/mobile/screens/m_comments_screen.dart';
import 'package:insta_clone/mobile/screens/m_profile_screen.dart';
import 'package:insta_clone/mobile/widgets/like_animation.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../resources/firestore_methods.dart';

class PostCard extends StatefulWidget {
  final Map<String,dynamic>? snap;

  PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.snap!['profileImage']),
                radius: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MProfileScreen(uid: widget.snap!['uid'])));
                    },
                    child: Text(
                      widget.snap!['userName'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    //TODO:Implement functionality
                  },
                  icon: Icon(Icons.more_vert)),
            ],
          ),
          GestureDetector(
            onDoubleTap: () {
              FirestoreMethods().likePost(
                  user!.uid, widget.snap!['postId'], widget.snap!['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                height: MediaQuery.of(context).size.height * 0.32,
                width: double.infinity,
                child: Image.network(
                  widget.snap!['postUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                opacity: isLikeAnimating ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: LikeAnimation(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 80,
                  ),
                  duration: Duration(milliseconds: 400),
                  isAnimating: isLikeAnimating,
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                ),
              ),
            ]),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap!['likes'].contains(user!.uid),
                child: IconButton(
                  onPressed: () {
                    FirestoreMethods().likePost(
                        user!.uid, widget.snap!['postId'], widget.snap!['likes']);
                  },
                  icon: widget.snap!['likes'].contains(user.uid)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                        ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MCommentsScreen.routeName,arguments: [widget.snap!['postId'].toString()]);
                },
                icon: const Icon(Icons.comment_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border),
                    )),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.snap!['likes'].length} Likes",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: widget.snap!['userName'],
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    TextSpan(
                        text: " ${widget.snap!['description']}",
                        style: TextStyle(fontSize: 16))
                  ]),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    "view all 208 comments",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap!['datePublished'].toDate()),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
