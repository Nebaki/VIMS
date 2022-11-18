import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/otp.dart';
import 'package:mob_app/screen/home/hompage.dart';
import 'package:mob_app/screen/sign_in/signin.dart';
import 'package:mob_app/screen/sign_up/Signup.dart';
import 'package:mob_app/util/themes.dart';
import 'package:provider/provider.dart';
import 'provider/connectivity_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart';
import 'screen/profile/components/profile_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });
  final loginController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: Signin(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: const SignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: const Homepage(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: const ProfileEdit(),
        ),
      ],
      child: GetMaterialApp(theme: theme(), getPages: AppPages.routes),
    );
  }
}
