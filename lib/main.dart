import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/helper/social_binding.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/shared/network/local/catch_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/themes/Themes.dart';
import 'package:social_app/view/login_screen.dart';
import 'package:social_app/view/social_layout.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();
  uId=CacheHelper.getData(key: "uId");
  Widget startWidget;
  if(uId !=null){
    startWidget=const SocialLayout();
  }else {
    startWidget=LoginScreen();
  }
  runApp(
    MyApp(
      startingWidget: startWidget,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startingWidget}) : super(key: key);
  final Widget startingWidget;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: SocialBinding(),
      title: 'Social App',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: startingWidget,
    );
  }
}