import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_clone/mobile/screens/m_login_screen.dart';
import 'package:insta_clone/mobile/widgets/TextInputField.dart';
import 'package:insta_clone/utils/colours.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: SvgPicture.asset('assets/ic_instagram.svg',color: Colors.white,width: 200,),
                      ),

                      SizedBox(height:20 ,),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius:55,
                            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1489278353717-f64c6ee8a4d2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21pbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
                          ),
                          Positioned(
                            bottom: -5,
                            right: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: IconButton(onPressed: (){
                                  //TODO:Upload image from the gallery
                                }, icon: Icon(Icons.add_a_photo_outlined))),
                          )
                        ],
                      ),
                      SizedBox(height:20 ,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Column(
                          children: [
                            TextInputField(textController: _emailController, hintText: "Enter your email",textInputType: TextInputType.emailAddress,),
                            SizedBox(height: 25,),
                            TextInputField(textController: _passwordController, hintText: "Enter your password",isPass: true,textInputType: TextInputType.text,),
                            SizedBox(height: 25,),
                            TextInputField(textController: _bioController, hintText: "Enter your bio",textInputType: TextInputType.text,),
                            SizedBox(height: 25,),
                            TextInputField(textController: _userNameController, hintText: "Enter your user name",textInputType: TextInputType.text,),
                            SizedBox(height: 25,),
                            InkWell(
                              onTap: (){
                                //TODO:User login
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: blueColor,
                                ),
                                child: Center(child: Text("Sign Up",style: TextStyle(fontSize: 20),)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
