import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderid;
  final String senderemail;
  final String receiverid;
  final String message;
  final Timestamp timestamp;
  Message(
      {required this.senderid,
      required this.message,
      required this.senderemail,
      required this.receiverid,
      required this.timestamp});
  //convert into map
  Map<String, dynamic> tomap() {
    return {
      'senderid': senderid,
      'senderemail': senderemail,
      'receiver': receiverid,
      'messages': message,
      'timestamp': timestamp
    };
  }
}
