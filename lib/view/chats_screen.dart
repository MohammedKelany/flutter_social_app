import 'package:flutter/material.dart';
import 'package:social_app/controller/social_controller.dart';
import 'package:social_app/models/user_model.dart';

import 'package:get/get.dart';
import 'package:social_app/view/chat_detailed_screen.dart';

final SocialController socialController=Get.find();
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(builder: (controller) {
      return ListView.separated(
        shrinkWrap: true,
        physics:const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildChatItem(
          controller.userModels[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 5,
        ),
        itemCount: controller.userModels.length,
      );
    });
  }
}

Widget buildChatItem(UserModel model) {
  return InkWell(
    onTap: () {
      socialController.getMessages(model.userID!);
      Get.to(()=>ChatDetailedScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(model.image!),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(model.username!)
        ],
      ),
    ),
  );
}
