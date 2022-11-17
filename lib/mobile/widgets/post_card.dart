import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key,required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(snap['profileImage']),radius: 20,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(snap['userName'],style: TextStyle(fontSize: 16),),
                ),
              ),
              IconButton(onPressed: (){
                //TODO:Implement functionality
              }, icon: Icon(Icons.more_vert)),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            height: MediaQuery.of(context).size.height*0.32,
            width: double.infinity,
            child: Image.network(snap['postUrl'],fit: BoxFit.cover,),
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,),),
              IconButton(onPressed: (){}, icon: Icon(Icons.comment_outlined),),
              IconButton(onPressed: (){}, icon: Icon(Icons.share),),
              Expanded(child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: (){},icon: Icon(Icons.bookmark_border),)),),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text("${snap['likes'].length} Likes",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: RichText(text: TextSpan(children: [
                  TextSpan(text: snap['userName'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                  TextSpan(text: " ${snap['description']}",style: TextStyle(fontSize: 16))
                ]),),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.only(top: 3),
                  child: Text("view all 208 comments",style: TextStyle(color: Colors.grey,fontSize: 13),),
                ),
              ),

              Align(
                  alignment: Alignment.topLeft,
                  child: Text(DateFormat.yMMMd().format(snap['datePublished'].toDate()),style: TextStyle(color: Colors.grey,fontSize: 12),)),
            ],
          )
        ],
      ),
    );
  }
}
