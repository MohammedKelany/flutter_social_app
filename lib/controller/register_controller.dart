import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/network/local/catch_helper.dart';
import 'package:social_app/view/social_layout.dart';
import 'package:social_app/view/widgets/shared_components.dart';

class RegisterController extends GetxController {
  bool isVisible = false;

  bool changePassVisibility() {
    isVisible = !isVisible;
    update();
    return isVisible;
  }

  bool isLoading = false;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    isLoading = true;
    update();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        userCreate(
          username: name,
          userID: value.user!.uid,
          email: email,
          phoneNumber: phone,
        );
        CacheHelper.setData(
          key: "uId",
          value: value.user!.uid,
        );
        getToast(
          text: "User Created Successfully",
          state: ToastStates.SUCCESS,
        );
        isLoading = false;
        update();
        Get.offAll(const SocialLayout());
      },
    ).catchError(
      (error) {
        getToast(
          text: "Error While Registration",
          state: ToastStates.ERROR,
        );
        isLoading = false;
        getToast(
          text: "User Creation Failed",
          state: ToastStates.ERROR,
        );
        update();
      },
    );
  }

  void userCreate({
    required String username,
    required String userID,
    required String email,
    required String phoneNumber,
  }) {
    UserModel userModel = UserModel(
        username: username,
        email: email,
        userID: userID,
        phoneNumber: phoneNumber,
        isVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .set(userModel.toJson())
        .then(
      (value) {
        getToast(
          text: "User Created Successfully",
          state: ToastStates.SUCCESS,
        );
      },
    ).catchError(
      (error) {
        getToast(
          text: error.toString(),
          state: ToastStates.SUCCESS,
        );
      },
    );
  }
}
