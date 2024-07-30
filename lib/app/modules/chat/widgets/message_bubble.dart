import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String name;
  final String time;
  final bool isMe;
  final bool isRead;

  const MessageBubble(
      this.message, this.name, this.time, this.isMe, this.isRead,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: Get.width * 3 / 4),
          decoration: BoxDecoration(
            color: isMe
                ? const Color.fromARGB(255, 188, 252, 191)
                : const Color.fromARGB(255, 155, 210, 255),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                maxLines: null,
                softWrap: true,
                style: TextStyle(color: Colors.black, fontSize: 16),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(color: greyColor, fontSize: 10),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Visibility(
                      visible: isMe ? true : false,
                      child: isRead
                          ? Icon(
                              Icons.done_all,
                              color: Colors.blue,
                            )
                          : Icon(
                              Icons.done,
                              color: greyColor,
                            ))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
