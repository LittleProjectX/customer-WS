import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String senderPhone;
  final String receiverId;
  final String message;
  final Timestamp timeStamps;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.senderPhone,
    required this.receiverId,
    required this.message,
    required this.timeStamps,
    required this.isRead,
  });

  factory Message.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Message(
      id: doc.id,
      senderId: data['senderId'],
      senderPhone: data['senderPhone'],
      receiverId: data['receiverId'],
      message: data['message'],
      timeStamps: data['timeStamp'],
      isRead: data['isRead'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderPhone': senderPhone,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamps,
      'isRead': isRead,
    };
  }
}
