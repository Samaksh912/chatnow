import 'package:chatnow/Services/authorizations/loginorreg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chatnow/pages/homepage.dart';



class authgate extends StatelessWidget {
  const authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
        //if user is logged in
        if(snapshot.hasData){
          return homepage();
        }
        else{
          return logorreg();
        }

      }),
    );
  }
}
