import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/social_controller.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/view/login_screen.dart';
import 'package:social_app/view/update_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<SocialController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 200,
                      alignment: Alignment.topCenter,
                      child: Image(
                        height: 140,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        image: NetworkImage(controller.userModel!.cover!),
                      ),
                    ),
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            NetworkImage(controller.userModel!.image!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  controller.userModel!.username!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  controller.userModel!.bio!,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 13,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Posts",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 13,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "254",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Photos",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 13,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "10K",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Followers",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 13,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "65",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Following",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 13,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {}, child: const Text("Add Photo"))),
                    OutlinedButton(
                        onPressed: () {
                          Get.to(() => const UpdateProfileScreen());
                        },
                        child: const Icon(Icons.edit_outlined)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    onPressed: () {
                      controller.signOut();
                    },
                    child: const Text("Sign Out")),
              ],
            ),
          );
        }),
      ),
    );
  }
}
