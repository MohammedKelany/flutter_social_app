import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/social_controller.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';

final SocialController socialController = Get.find();

class ChatDetailedScreen extends StatelessWidget {
  const ChatDetailedScreen({Key? key, required this.userModel})
      : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userModel.image!),
                radius: 25,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                userModel.username!,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (controller.messages[index].senderId ==
                          controller.userModel!.userID) {
                        return buildMyMessages(controller.messages[index]);
                      } else {
                        return buildSenderMessages(controller.messages[index]);
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: controller.messages.length),
              ),
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[100] as Color,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: controller.messageController,
                          decoration: const InputDecoration(
                            hintText: "type your message here ...",
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (value) {
                            controller.sendMessages(
                              userModel.userID!,
                              controller.messageController.text,
                              DateTime.now().toString(),
                            );
                          },
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if(controller.messageController.text.isNotEmpty){
                          controller.sendMessages(
                            userModel.userID!,
                            controller.messageController.text,
                            DateTime.now().toString(),
                          );
                        }
                      },
                      minWidth: 1,
                      height: 50,
                      color: Colors.blue,
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

Widget buildMyMessages(MessageModel model) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(model.text!),
    ),
  );
}

Widget buildSenderMessages(MessageModel model) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(model.text!),
    ),
  );
}
