import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/colours.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class MAddPostScreen extends StatefulWidget {
  const MAddPostScreen({Key? key}) : super(key: key);

  @override
  State<MAddPostScreen> createState() => _MAddPostScreenState();
}

class _MAddPostScreenState extends State<MAddPostScreen> {
  Uint8List? _image;
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text("Create a post"),
              children: [
                SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    Uint8List? file = await pickImage(ImageSource.camera);
                    setState(() {
                      _image=file;
                    });
                  },
                  child: Text("Take a picture"),
                ),
                SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    Uint8List? file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _image=file;
                    });
                  },
                  child: Text("Upload from gallery"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    User? _userDetails = Provider.of<UserProvider>(context).getUser;
    return _image == null
        ? Center(
            child: IconButton(
              onPressed: ()=>_selectImage(context),
              icon: Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  //TODO:Implement back option
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text("Post to"),
            ),
            body: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(_userDetails!.imageUrl),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Write a caption..",
                            hintStyle: TextStyle(fontSize: 14),
                            border: InputBorder.none,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                          _image!,
                        )
                      )),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
