import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderid;
  final String senderemail;
  final String recieverid;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.timestamp,
    required this.message,
    required this.recieverid,
    required this.senderemail,
    required this.senderid,

});
  Map<String, dynamic> toMap(){
    return {
      'senderid': senderid,
      'senderemail': senderemail,
      'messages': message,
      'recieverid': recieverid,
      'timestamp': timestamp,
    };
  }
}