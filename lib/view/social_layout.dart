import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/social_controller.dart';
import 'package:social_app/view/widgets/shared_components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(
        init: Get.put(SocialController(),permanent: false),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                controller.titles[controller.currentIndex],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_outlined),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: controller.userModel != null ,
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!controller.userModel!.isVerified!)
                      ColoredBox(
                        color: Colors.amber.withOpacity(.6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(Icons.info_outline),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: Text("Send Email Verification")),
                              TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification()
                                        .then(
                                      (value) {
                                        getToast(
                                          text: "Check Your Mail",
                                          state: ToastStates.SUCCESS,
                                        );
                                      },
                                    ).catchError(
                                      (error) {
                                        getToast(
                                          text: error.toString(),
                                          state: ToastStates.ERROR,
                                        );
                                      },
                                    );
                                  },
                                  child: const Text("Send"))
                            ],
                          ),
                        ),
                      ),
                    controller.screens[controller.currentIndex],
                  ],
                );
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              elevation: 0,
              backgroundColor: Colors.white,
              items: controller.bNBItems,
              currentIndex: controller.currentIndex,
              onTap: (value) => controller.changeIndex(value),
            ),
          );
        });
  }
}
