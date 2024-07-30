import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/chat_service.dart';
import 'package:waroengsederhana/app/models/message.dart';
import 'package:waroengsederhana/app/modules/chat/controllers/chat_controller.dart';
import 'package:waroengsederhana/app/modules/chat/widgets/message_bubble.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ChatService chatC = ChatService();
  AuthService authC = AuthService();
  final msgC = Get.put(ChatController());
  final userId = Get.arguments['uId'];
  final username = Get.arguments['name'];
  final userImage = Get.arguments['image'];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatC.getMessage(authC.auth.currentUser!.uid, userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          String chatRoomId =
              chatC.getRoomId(authC.auth.currentUser!.uid, userId);

          final snap = snapshot.data!.docs;

          List<Message> allMsg = snap.map((doc) {
            return Message.fromFirestore(doc);
          }).toList();

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 90, 10, 80),
                  child: ListView.builder(
                    itemCount: allMsg.length,
                    itemBuilder: (context, index) {
                      bool isMe = false;
                      bool isRead = allMsg[index].isRead;
                      DateTime time = allMsg[index].timeStamps.toDate();

                      // Format jam (contoh: 08:30 AM)
                      String formattedTime = DateFormat('h:mm a').format(time);

                      if (allMsg[index].senderId ==
                          authC.auth.currentUser!.uid) {
                        isMe = true;
                      } else {
                        // Tandai pesan sebagai dibaca jika bukan dari pengguna saat ini dan belum dibaca
                        if (!allMsg[index].isRead) {
                          chatC.markMessageAsRead(chatRoomId, allMsg[index].id);
                        }
                      }

                      return MessageBubble(
                          allMsg[index].message,
                          isMe ? 'Saya' : username,
                          formattedTime,
                          isMe,
                          isRead);
                    },
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 120,
                      color: whiteColor,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => Get.back(),
                                  icon: const Icon(Icons.arrow_back)),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.viewimage,
                                      arguments: userImage);
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(userImage),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                username,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                hintText: 'Kirim pesan',
                              ),
                              controller: msgC.msg,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              chatC.sendMessage(userId, msgC.msg.text);
                              msgC.msg.clear();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: tabColor),
                              child: const Icon(
                                Icons.send,
                                color: whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
        return const LoadingView();
      },
    );
  }
}
