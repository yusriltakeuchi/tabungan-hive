import 'package:flutter/material.dart';

class CustomTextfieldBorder extends StatefulWidget {
  String title;
  TextInputAction action;
  TextInputType type;
  TextEditingController controller;
  bool secureText;
  bool readOnly;

  CustomTextfieldBorder({
    this.title, this.action, this.type,
    this.controller, this.secureText = false,
    this.readOnly = false
  });

  @override
  _CustomTextfieldBorderState createState() => _CustomTextfieldBorderState();
}

class _CustomTextfieldBorderState extends State<CustomTextfieldBorder> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: widget.action,
      keyboardType: widget.type,
      obscureText: widget.secureText,
      style: TextStyle(
        color: Colors.blue,
      ),
      maxLines: 1,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        hintText: widget.title,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.blue
        ),
        enabledBorder: OutlineInputBorder(      
          borderSide: BorderSide(color: Colors.blue, width: 1)
        ),  
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),  
      ),
    );
  }
}