import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/social_controller.dart';
import 'package:social_app/view/widgets/shared_components.dart';
import 'package:social_app/view/widgets/text_form_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    controller.updateUserData(
                      username: controller.userNameController.text,
                      bio: controller.bioController.text,
                      phone: controller.phoneController.text,
                    );
                  },
                  child: const Text(
                    "UPDATE",
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
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
                        child: Stack(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          alignment: Alignment.topRight,
                          children: [
                            Image(
                              height: 140,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              image: controller.coverImage == null
                                  ? NetworkImage(controller.userModel!.cover!)
                                  : FileImage(controller.coverImage!)
                                      as ImageProvider,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  onPressed: () {
                                    controller.getCoverImage();
                                  },
                                  icon: const Icon(Icons.camera_alt_outlined),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: controller.profileImage == null
                                  ? NetworkImage(controller.userModel!.image!)
                                  : FileImage(controller.profileImage!)
                                      as ImageProvider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                onPressed: () {
                                  controller.getProfileImage();
                                },
                                icon: const Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        if (controller.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                customButton(
                                  onPressed: () {
                                    controller.uploadCoverImage(
                                      username:
                                          controller.userNameController.text,
                                      bio: controller.bioController.text,
                                      phone: controller.phoneController.text,
                                    );
                                  },
                                  color: Colors.blue,
                                  text: "Update Cover",
                                  width: double.infinity,
                                ),
                                  const SizedBox(
                                  height: 5,
                                ),
                                if(controller.coverLoading)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if(controller.coverImage!=null&&controller.profileImage!=null)
                          const SizedBox(
                          width: 5,
                        ),
                        if (controller.profileImage != null)
                          Expanded(
                          child: Column(
                            children: [
                              customButton(
                                onPressed: () {
                                  controller.uploadProfileImage(
                                    username:
                                        controller.userNameController.text,
                                    bio: controller.bioController.text,
                                    phone: controller.phoneController.text,
                                  );
                                },
                                color: Colors.blue,
                                text: "Update Profile",
                                width: double.infinity,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if(controller.profileLoading)
                              const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                      label: "userName",
                      prefixIcon: Icons.supervised_user_circle_outlined,
                      controller: controller.userNameController,
                      validation: "userName is Empty !!!",
                      inputType: TextInputType.text),
                  CustomTextFormField(
                      label: "bio",
                      prefixIcon: Icons.data_usage_sharp,
                      controller: controller.bioController,
                      validation: "Bio is Empty !!!",
                      inputType: TextInputType.text),
                  CustomTextFormField(
                    label: "phone",
                    prefixIcon: Icons.phone_outlined,
                    controller: controller.phoneController,
                    validation: "PhoneNumber",
                    inputType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
