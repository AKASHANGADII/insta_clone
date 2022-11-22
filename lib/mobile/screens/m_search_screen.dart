import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:insta_clone/mobile/screens/m_profile_screen.dart';
import 'package:insta_clone/utils/colours.dart';

class MSearchScreen extends StatefulWidget {
  @override
  State<MSearchScreen> createState() => _MSearchScreenState();
}

class _MSearchScreenState extends State<MSearchScreen> {
  TextEditingController textController = TextEditingController();

  bool showUsers = false;
  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Container(
            height: 42,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: "Search",
                        hintStyle: TextStyle(fontSize: 14)
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        setState(() {
                          showUsers = true;
                        });
                      }
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          ),
        ),
        body: showUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('userName',
                        isGreaterThanOrEqualTo: textController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if ((snapshot.data as dynamic).docs.length == 0) {
                    return Center(
                      child: Text("No users found"),
                    );
                  }
                  return ListView.builder(
                      itemCount: (snapshot.data as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            textController.clear();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MProfileScreen(uid: snapshot.data!.docs[index]['uid'])));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(
                                  (snapshot.data as dynamic).docs[index]
                                      ['profileImage']),
                            ),
                            title: Text(
                              (snapshot.data as dynamic).docs[index]['userName'],
                            ),
                          ),
                        );
                      });
                },
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.custom(
                    semanticChildCount: snapshot.data!.docs.length,
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: [
                        QuiltedGridTile(2, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      childCount: snapshot.data!.docs.length,
                      (context, index) => Container(
                        child: Image.network(
                            snapshot.data!.docs[index]['postUrl'],
                        fit: BoxFit.cover,),
                      ),
                    ),
                  );
                }));
  }
}
