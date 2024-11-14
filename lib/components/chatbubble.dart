import 'package:chatnow/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:chatnow/theme/themeprovider.dart';
import 'package:provider/provider.dart';

class Chatbubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
  const Chatbubble({super.key, required this.message, required this.iscurrentuser});

  @override
  Widget build(BuildContext context) {
    bool isdarkmode = Provider.of<Themeprovider>(context, listen: false).isdarkmode;
    return Container(
      decoration: BoxDecoration(
        color: iscurrentuser ? (isdarkmode? Colors.blueGrey : Colors.blue.shade300) : (isdarkmode ? Colors.green.shade300 : Colors.green.shade600),
        borderRadius: BorderRadius.circular(15)
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 20),
      child: Text(message, style: TextStyle(color: iscurrentuser ?  Colors.white : (isdarkmode ? Colors.white :  Colors.black  ),
      ),
      )
    );
  }
}
