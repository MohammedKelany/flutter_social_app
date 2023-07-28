import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/login_controller.dart';
import 'package:social_app/view/register_screen.dart';
import 'package:social_app/view/widgets/text_form_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("LOGIN", style: Theme.of(context).textTheme.headline4),
                  Text(
                    "Login now to communicate with friends.",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFormField(
                      label: "Email",
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validation:"Email is Empty !!!",
                      inputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<LoginController>(
                    init: Get.put(LoginController()),
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
                        validation:"PassWord is Empty !!!",
                        inputType: TextInputType.visiblePassword,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            controller.userLogin(
                                email: emailController.text,
                                password: passController.text);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GetBuilder<LoginController>(
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
                                if (formKey.currentState!.validate()) {
                                  controller.userLogin(
                                      email: emailController.text,
                                      password: passController.text);
                                }
                              },
                              height: 40,
                              minWidth: double.infinity,
                              textColor: Colors.white,
                              child: const Text("Submit"),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Get.to(RegisterScreen());
                          },
                          child: const Text("REGISTER"))
                    ],
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
