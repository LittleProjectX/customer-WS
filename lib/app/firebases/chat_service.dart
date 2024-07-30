import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/models/message.dart';

class ChatService extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('owner');
  CollectionReference chats =
      FirebaseFirestore.instance.collection('chats_room');
  FirebaseAuth authn = FirebaseAuth.instance;

  Stream<QuerySnapshot<Object?>> getStreamUser() {
    return users.snapshots();
  }

  Future<void> sendMessage(String receiverId, String message) async {
    // mengambil pengguna
    final String currentUserId = authn.currentUser!.uid;
    final String currentPhone = authn.currentUser!.phoneNumber.toString();
    final Timestamp timeStamp = Timestamp.now();

    // buat pesan baru
    Message newMessage = Message(
      id: '', // ID akan dihasilkan oleh Firestore
      senderId: currentUserId,
      senderPhone: currentPhone,
      receiverId: receiverId,
      message: message,
      timeStamps: timeStamp,
      isRead: false,
    );

    // buat room id dengan kode unik
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // membuat id room sama untuk dua pengguna
    String chatRoomId = ids.join('_');

    // tambah pesan ke database
    DocumentReference messageRef = await chats
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    // Update message ID setelah ditambahkan ke Firestore
    await messageRef.update({'id': messageRef.id});
  }

  String getRoomId(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    return ids.join('_');
  }

  Future<void> markMessageAsRead(String chatRoomId, String messageId) async {
    // update isRead menjadi true
    await chats.doc(chatRoomId).collection('messages').doc(messageId).update({
      'isRead': true,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      String userId, otherUserId) {
    // mengambil room id
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // mengambil pesan sesuai room id
    return chats
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
