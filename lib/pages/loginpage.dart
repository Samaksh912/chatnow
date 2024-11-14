import 'package:chatnow/Services/authorizations/authservices.dart';
import 'package:chatnow/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:chatnow/components/texts.dart';
import 'package:chatnow/Services/authorizations/authservices.dart';

class loginpage extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  // tap func

     final void Function()? onTap;

  loginpage({super.key, required this.onTap});
  //login func
   void login(BuildContext context) async {
    //authorization
    final Authservice = AuthService();
    try{
      await Authservice.signinemailpass(emailcontroller.text, pwcontroller.text,);
    }
    catch(e){
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            //logo
            Icon(Icons.message,size: 65,color: Theme.of(context).colorScheme.primary,),
            //welcome back
            const SizedBox(height: 50,),
            Text("Welcome Back",style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),),
            //email text
            const SizedBox(height: 29,),
            Mytextfield(
              hintText: "Email",
              obscureText: false,
              controller: emailcontroller,

            ),
            const SizedBox(height: 15,),
            //pw
            Mytextfield(
              hintText: "Password",
              obscureText: true,
              controller: pwcontroller,

            ),
            const SizedBox(height: 29,),
            //login button
            mybutton(
              text: "Login",
              ontap: () => login(context),
            ),
            const SizedBox(height: 25,),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not registered?",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}
