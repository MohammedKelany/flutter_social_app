import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/social_controller.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Post"),
            actions: [
              TextButton(
                onPressed: () {
                  if (controller.postImage == null) {
                    controller.createPost(
                        text: controller.postTextController.text,
                        dateTime: DateTime.now().toString());
                  } else {
                    controller.uploadPostImage(
                        text: controller.postTextController.text,
                        dateTime: DateTime.now().toString());
                  }
                },
                child: const Text(
                  "POST",
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(

                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      if (controller.postLoading) const LinearProgressIndicator(),
                      if (controller.postLoading)
                        const SizedBox(
                          height: 20,
                        ),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://img.freepik.com/free-photo/young-man-student-with-notebooks-showing-thumb-up-approval-smiling-satisfied-blue-studio-background_1258-65597.jpg"),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            controller.userModel!.username!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.postTextController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "What do you Think...",
                          ),
                        ),
                      ),
                      if (controller.postImage != null)
                        Stack(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          alignment: Alignment.topRight,
                          children: [
                            Image(
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image: FileImage(controller.postImage!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  onPressed: () {
                                    controller.removePostImage();
                                  },
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                controller.getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.photo_size_select_actual_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("add photo"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "# tags",
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
