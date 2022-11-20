import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  var snap;
  CommentCard({required this.snap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
                snap['profileUrl']),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 17),
                    children: [
                      TextSpan(
                          text: "${snap['userName']} ",style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: snap['commentText']),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(DateFormat.yMMMd().format(snap['dateTime'].toDate()),style: TextStyle(fontSize: 10),)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
