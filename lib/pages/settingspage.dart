import 'package:chatnow/theme/darkmode.dart';
import 'package:chatnow/theme/themeprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        //logout button

      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(16)
        ),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //darkmode
            Text("Dark Mode"),

            //toggleswitch
            CupertinoSwitch(value: Provider.of<Themeprovider>(context, listen: false).isdarkmode,
                onChanged: (value)=>Provider.of<Themeprovider>(context, listen: false).toggletheme())
          ],
        ),
      ),
    );
  }
}
