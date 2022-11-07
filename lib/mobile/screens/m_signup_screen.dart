import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/mobile/screens/m_home_screen.dart';
import 'package:insta_clone/mobile/screens/m_login_screen.dart';
import 'package:insta_clone/mobile/widgets/TextInputField.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/utils/colours.dart';
import 'package:insta_clone/utils/utils.dart';

class MSignUpScreen extends StatefulWidget {
  static const routeName='/m-sign-up-screen';
  const MSignUpScreen({Key? key}) : super(key: key);


  @override
  State<MSignUpScreen> createState() => _MSignUpScreenState();
}

class _MSignUpScreenState extends State<MSignUpScreen> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _bioController=TextEditingController();
  TextEditingController _userNameController=TextEditingController();
  Uint8List? _image;
  bool _isLoading=false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }
  void SelectImage() async{
    Uint8List im=await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
  }

  void signUpUser() async{
    setState(() {
      _isLoading=true;
    });
    await AuthMethods().signUpUser(_userNameController.text, _emailController.text, _passwordController.text, _bioController.text,_image!).then((value){
      if(value=="Successfully created"){
        Navigator.of(context).pushReplacementNamed(MHomeScreen.routeName);
      }
      else{
        showSnackBar(context, value);
      }
    });
    setState(() {
      _isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SvgPicture.asset('assets/ic_instagram.svg',color: Colors.white,width: 200,),
                    ),

                    SizedBox(height:20 ,),
                    Stack(
                      children: [
                        _image!=null? CircleAvatar(
                    radius:55,
                      backgroundImage:MemoryImage(_image!),
                    ): CircleAvatar(
                          radius:55,
                          backgroundImage:NetworkImage("https://images.unsplash.com/photo-1489278353717-f64c6ee8a4d2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21pbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
                        ),
                        Positioned(
                          bottom: -5,
                          right: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: IconButton(onPressed: SelectImage, icon: Icon(Icons.add_a_photo_outlined))),
                        )
                      ],
                    ),
                    SizedBox(height:20 ,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Column(
                        children: [
                          TextInputField(textController: _emailController, hintText: "Enter your email",textInputType: TextInputType.emailAddress,),
                          SizedBox(height: 15,),
                          TextInputField(textController: _passwordController, hintText: "Enter your password",isPass: true,textInputType: TextInputType.text,),
                          SizedBox(height:15,),
                          TextInputField(textController: _bioController, hintText: "Enter your bio",textInputType: TextInputType.text,),
                          SizedBox(height: 15,),
                          TextInputField(textController: _userNameController, hintText: "Enter your user name",textInputType: TextInputType.text,),
                          SizedBox(height: 15,),
                          InkWell(
                            onTap:signUpUser,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: blueColor,
                              ),
                              child: Center(child: _isLoading?CircularProgressIndicator(color: Colors.white,):Text("Sign Up",style: TextStyle(fontSize: 20),)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ? "),
                    InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, MLoginScreen.routeName);
                        },
                        child: Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
