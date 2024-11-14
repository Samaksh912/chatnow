import 'package:chatnow/Services/authorizations/authservices.dart';
import 'package:chatnow/Services/chat/chatservice.dart';
import 'package:chatnow/components/chatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/texts.dart';

class chatpage extends StatefulWidget {
  final String recieveremail;
  final String recieverid;

  chatpage({super.key, required this.recieveremail, required this.recieverid});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  //texxt controller
  final TextEditingController _messagecontroller = TextEditingController();

  //chat and auth service
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  //for text field focus for when too many messages it want it to autoscroll

  FocusNode myfocusnode = FocusNode();

  @override
  void initState() {
    super.initState();
    //add listener a this focus node
    myfocusnode.addListener(() {
      if (myfocusnode.hasFocus) {
        //if in focus give delay to wait for keyboear to showup
        //then the amount of remaining space on screen will be calculted
        //then scrooll down
        Future.delayed(const Duration(milliseconds: 600),
              () => scrolldown(),
        );
      }
    });
    //wait for listview to be built, then scroll down to bottom
    Future.delayed(const Duration(milliseconds: 500),
        () =>scrolldown(),
    );
  }

  @override
  void dispose() {
    myfocusnode.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();

  void scrolldown() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn);
  }

  //sending messages
  void sendmessage() async {
    //if there is something to send
    if (_messagecontroller.text.isNotEmpty) {
      //then send the message
      await _chatService.sendmessage(
          widget.recieverid, _messagecontroller.text);
      //clear the text controller
      _messagecontroller.clear();
    }
    scrolldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recieveremail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        //logout button

      ),
      body: Column(
        children: [
          //displaying of messages
          Expanded(child: _buildmessagelist()
          ),
          //user input
          _builduserinput(),
        ],
      ),
    );
  }

  //buildmessagelist function
  Widget _buildmessagelist() {
    String senderid = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getmessage(widget.recieverid, senderid),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        //returning the list view
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildmessageitem(doc))
              .toList(),
        );
      },
    );
  }

  //build message item function
  Widget _buildmessageitem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // is curretn user
    bool iscurrentuser = data['senderid'] == _authService.getCurrentUser()!.uid;

    //if recieving messages then align messages to right or we can say if sender is the current user
    var alignment = iscurrentuser ? Alignment.centerRight : Alignment
        .centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: iscurrentuser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Chatbubble(message: data["messages"], iscurrentuser: iscurrentuser)
          ],
        ));
  }

  //build message input or user input
  Widget _builduserinput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          //the text field should take up most of the space
          Expanded(child: Mytextfield(
            controller: _messagecontroller,
            hintText: "Type your message here",
            obscureText: false,
            focusNode: myfocusnode,


          )
          ),
          //send button
          Container(
            decoration: const BoxDecoration(
                color: Colors.black54, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: sendmessage, icon: const Icon(Icons.send_rounded),
            ),
          )
        ],
      ),
    );
  }
}
