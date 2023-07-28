import 'package:get/get.dart';
import 'package:social_app/controller/login_controller.dart';
import 'package:social_app/controller/register_controller.dart';
import 'package:social_app/controller/social_controller.dart';

class SocialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => SocialController());
  }
}
