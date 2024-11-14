import 'package:flutter/material.dart';
import 'package:chatnow/Services/authorizations/authservices.dart';
import '../components/buttons.dart';
import '../components/texts.dart';

class registerpage extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  final TextEditingController confirmpwcontroller = TextEditingController();

  //tap func

  final void Function()? onTap;

  registerpage({super.key,required this.onTap});

 //regist func
  void register(BuildContext context){
    final auth = AuthService();
    //password match  =  user created
    if(pwcontroller.text == confirmpwcontroller.text) {
      try {
        auth.signupemailpass(emailcontroller.text, pwcontroller.text);
      }


    catch(e) {
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text(e.toString()),
          ));
    }

    }
    else{
      showDialog(context: context, builder: (context) =>
          const AlertDialog(
            title: Text("Password don't match!"),
          ));
    }
    //password no match = error to fix

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
            Text("Fill the below fields",style: TextStyle(
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
            const SizedBox(height: 8,),
            //pw
            Mytextfield(
              hintText: "Password",
              obscureText: true,
              controller: pwcontroller,

            ),
        const SizedBox(height: 15,),
        //pw confirm
        Mytextfield(
          hintText: "Confirm Password",
          obscureText: true,
          controller: confirmpwcontroller,
        ),

            const SizedBox(height: 29,),
            //login button
            mybutton(
              text: "Register",
              ontap: () => register(context),
            ),
            const SizedBox(height: 25,),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
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
