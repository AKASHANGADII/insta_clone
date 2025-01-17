import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/mobile/screens/m_home_screen.dart';
import 'package:insta_clone/mobile/screens/m_signup_screen.dart';
import 'package:insta_clone/mobile/widgets/text_input_field.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/utils/colours.dart';
import 'package:insta_clone/utils/utils.dart';

class MLoginScreen extends StatefulWidget {
  static const routeName='/m-login-screen';
  @override
  State<MLoginScreen> createState() => _MLoginScreenState();
}

class _MLoginScreenState extends State<MLoginScreen> {
  TextEditingController _emailController=TextEditingController();

  TextEditingController _passwordController=TextEditingController();
  bool _isLoading=false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void loginUser() async{
    setState(() {
      _isLoading=true;
    });
    await AuthMethods().loginUser(_emailController.text, _passwordController.text).then((value){
      if(value=="Success"){
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
                        child: SvgPicture.asset('assets/ic_instagram.svg',color: Colors.white,width: 220,),
                      ),
                      SizedBox(height:80 ,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Column(
                          children: [
                            TextInputField(textController: _emailController, hintText: "Email",textInputType: TextInputType.emailAddress,),
                            SizedBox(height: 25,),
                            TextInputField(textController: _passwordController, hintText: "Password",isPass: true,textInputType: TextInputType.text,),
                            SizedBox(height: 25,),
                            InkWell(
                              onTap: loginUser,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: blueColor,
                                ),
                                child: Center(child: _isLoading?CircularProgressIndicator(color: Colors.white,):Text("Log In",style: TextStyle(fontSize: 20),)),
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
                    Text("Don\'t have an account ? "),
                    InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, MSignUpScreen.routeName);
                        },
                        child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold),)),
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
