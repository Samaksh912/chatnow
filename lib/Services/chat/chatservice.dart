import 'package:chatnow/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // Get Firestore instance and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      List<Map<String, dynamic>> users = snapshot.docs.map((doc) {
        final user = doc.data() as Map<String, dynamic>; // Cast to the expected type
        print("Fetched User: $user"); // Log the entire user data
        return user;
      }).toList();

      print("Users fetched: $users"); // Log the list of users
      return users;
    });
  }

  // Send message
  Future<void> sendmessage(String recieverid, message) async {
    final String currentuserid = _auth.currentUser!.uid;
    final String currentuseremail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newmessage = Message(
      timestamp: timestamp,
      message: message,
      recieverid: recieverid,
      senderemail: currentuseremail,
      senderid: currentuserid,
    );

    // Constructing a chat room ID for the two users with uniqueness
    List<String> ids = [currentuserid, recieverid];
    ids.sort(); // Ensures that the two people using the chatroom have the same ID
    String chatroomid = ids.join('_');

    // Add new message to Firestore database
    await _firestore
        .collection("chatrooms")
        .doc(chatroomid)
        .collection("messages")
        .add(newmessage.toMap());
  }

  // Getting the message (kinda similar to sending)
  Stream<QuerySnapshot> getmessage(String userid, otheruserid) {
    // Constructing a chatroom ID for the 2 users
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join('_');

    return _firestore
        .collection("chatrooms")
        .doc(chatroomid)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
