import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/shared/network/local/catch_helper.dart';
import 'package:social_app/view/social_layout.dart';
import 'package:social_app/view/widgets/shared_components.dart';

class LoginController extends GetxController {
  bool isVisible = false;

  bool changePassVisibility() {
    isVisible = !isVisible;
    update();
    return isVisible;
  }

  bool isLoading = false;

  void userLogin({
    required String email,
    required String password,
  }) {
    isLoading = true;
    update();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        isLoading = false;
        getToast(
          text: "Login Successfully",
          state: ToastStates.SUCCESS,
        );
        uId = value.user!.uid;
        CacheHelper.setData(key: "uId", value: value.user!.uid);
        update();
        Get.off(() => const SocialLayout());
      },
    ).catchError(
      (error) {
        isLoading = false;
        getToast(
          text: error.toString(),
          state: ToastStates.ERROR,
        );
        update();
      },
    );
  }
}
