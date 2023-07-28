import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/register_controller.dart';
import 'package:social_app/view/widgets/text_form_field.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Register",
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Register now to communicate with friends.",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                      label: "Name",
                      prefixIcon: Icons.verified_user,
                      controller: nameController,
                      validation:"Name is Empty !!!",
                      inputType: TextInputType.emailAddress),
                  CustomTextFormField(
                      label: "Email",
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validation:"Email is Empty !!!",
                      inputType: TextInputType.emailAddress),
                  GetBuilder<RegisterController>(
                    init: Get.put(RegisterController()),
                    builder: (controller) {
                      return CustomTextFormField(
                        label: "PassWord",
                        prefixIcon: Icons.lock,
                        isPass: controller.isVisible,
                        suffixIcon: controller.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixPressed: () {
                          controller.changePassVisibility();
                        },
                        controller: passController,
                        validation: "PassWord is Empty !!!",
                        inputType: TextInputType.visiblePassword,
                        onSubmit: (value) {
                          if (registerFormKey.currentState!.validate()) {}
                        },
                      );
                    },
                  ),
                  CustomTextFormField(
                      label: "PhoneNumber",
                      prefixIcon: Icons.password,
                      controller: phoneController,
                      validation: "PhoneNumber is Empty !!!",
                      inputType: TextInputType.phone),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<RegisterController>(
                    builder: (controller) {
                      return ConditionalBuilder(
                        condition: !controller.isLoading,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (registerFormKey.currentState!.validate()) {
                                  controller.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                      phone: phoneController.text);
                                }
                              },
                              height: 40,
                              minWidth: double.infinity,
                              textColor: Colors.white,
                              child: const Text("Register"),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
