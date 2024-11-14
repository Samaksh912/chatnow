import 'package:chatnow/Services/authorizations/authservices.dart';
import 'package:chatnow/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:chatnow/Services/chat/chatservice.dart';
import '../components/Usertile.dart';
import 'ChatPage.dart';

class homepage extends StatelessWidget { // Changed to CamelCase
  homepage({super.key});

  // Chat auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: const drawerwidget(), // Ensure correct class name casing
      body: _buildUserList(),
    );
  }

  // Building list of users except for the current logged-in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        // Error check
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // Loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        // Finally returning the list view
        return ListView(
          children: snapshot.data!.map<Widget>((userdata) => buildUserListItem(userdata, context)).toList(),
        );
      },
    );
  }

  // Building individual list tile for user
  Widget buildUserListItem(Map<String, dynamic> userdata, BuildContext context) {
    String userEmail = userdata["email"] ?? ''; // Use lowercase 'email'

    if (userEmail != _authService.getCurrentUser()!.email) {
      // Display all users except the current user
      return UserTile(
        text: userEmail,
        onTap: () {
          // Tapped on the user, navigate to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => chatpage(
                recieveremail: userEmail,
                recieverid: userdata["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container(); // Return an empty container for the current user
    }
  }
}
