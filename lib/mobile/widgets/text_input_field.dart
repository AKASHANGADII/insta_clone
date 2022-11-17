import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController textController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  TextInputField({required this.textController,this.isPass=false,required this.hintText,required this.textInputType});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {

  OutlineInputBorder inputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      decoration: InputDecoration(
        hintText: widget.hintText,
       focusedBorder: inputBorder(context),
       enabledBorder: inputBorder(context),
        disabledBorder: inputBorder(context)
      ),
      obscureText: widget.isPass,
    );
  }


}
