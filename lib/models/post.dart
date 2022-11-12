class Post{
  final String description;
  final String uid;
  final String userName;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  Post({required this.description,required this.uid,required this.userName,required this.datePublished,required this.postId,required this.postUrl,required this.profileImage,required this.likes});

  Map<String,dynamic> toJson()=>{
    'userName':userName,
    'uid':uid,
    'postId':postId,
    'description':description,
    'datePublished':datePublished,
    'postUrl':postUrl,
    'profileImage':profileImage,
    'likes':likes,
  };
}