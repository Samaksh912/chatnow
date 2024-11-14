import 'package:flutter/material.dart';
import 'package:chatnow/pages/settingspage.dart';
import '../Services/authorizations/authservices.dart';

class drawerwidget extends StatelessWidget {
  const drawerwidget({super.key});
  void logout(){
    //get authservice
    final auth = AuthService();
    auth.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Column(children: [
           //logo
           DrawerHeader(child: Center(child: Icon(Icons.message_outlined,
             color: Theme.of(context).colorScheme.primary,
             size: 45,
           ),)),
           Padding(
             padding: const EdgeInsets.only(left: 20.0),
             child: ListTile(
               title: const Text("HOME"),
               leading: const Icon(Icons.home_rounded),
               onTap: (){
                 //pop the drawer
                 Navigator.pop(context);
               },

             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 20.0),
             child: ListTile(
               title: const Text("STATUS"),
               leading: const Icon(Icons.settings_outlined),
               onTap: (){
                 Navigator.pop(context);
                 //navigate to seetings aswell
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage())
                 );
               },

             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 20.0),
             child: ListTile(
               title: const Text("SETTINGS"),
               leading: const Icon(Icons.settings_outlined),
               onTap: (){
                 Navigator.pop(context);
                 //navigate to seetings aswell
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage())
                 );
               },

             ),
           ),
         ],),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,bottom: 30),
            child: ListTile(
              title: const Text("LOGOUT"),
              leading: const Icon(Icons.logout_outlined),
              onTap: logout,

            ),
          )
        ],
      ),
    );
    //home tile
  }
}
