import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/utils/colours.dart';

import '../widgets/post_card.dart';

class MFeedScreen extends StatelessWidget {
  const MFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title:  SvgPicture.asset("assets/ic_instagram.svg",color: Colors.white,height: 34,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
          if( !snapshot.hasData || snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.red,));
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index)=>PostCard(snap: snapshot.data!.docs[index].data(),),);
          }

      },
      ),
    );
  }
}
