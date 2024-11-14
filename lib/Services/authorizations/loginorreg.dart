import 'package:chatnow/pages/loginpage.dart';
import 'package:chatnow/pages/registerpage.dart';
import 'package:flutter/material.dart';

class logorreg extends StatefulWidget {
  const logorreg({super.key});

  @override
  State<logorreg> createState() => _logorregState();
}

class _logorregState extends State<logorreg> {
  bool showlogin = true;

  void togglepage(){
    setState(() {
      showlogin = !showlogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showlogin){
      return loginpage(
        onTap: togglepage,
      );
    }
    else{
      return registerpage(
        onTap: togglepage,
      );
    }
  }
}
