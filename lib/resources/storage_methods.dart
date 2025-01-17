import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods{

  Future<String> uploadImageToStorage(String childName,Uint8List image,bool isPost) async{
    FirebaseStorage _storage=FirebaseStorage.instance;
    FirebaseAuth _auth=FirebaseAuth.instance;
    Reference _ref=_storage.ref().child(childName).child(_auth.currentUser!.uid);
    var uuid=Uuid();
    if(isPost){
      _ref=_ref.child(uuid.v1());
    }
    UploadTask _uploadTask=_ref.putData(image);
    TaskSnapshot _snap=await _uploadTask;
    String downloadUrl=await _snap.ref.getDownloadURL();
    return downloadUrl;
  }
}