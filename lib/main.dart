import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/provider/user_provider.dart';
import 'package:mob_app/screen/home/hompage.dart';
import 'package:mob_app/screen/sign_in/signin.dart';
import 'package:mob_app/screen/sign_up/Signup.dart';
import 'package:mob_app/screen/otp/otp.dart';
import 'package:mob_app/screen/profile/components/profile_edit.dart';
import 'package:mob_app/screen/profile/profile_screen.dart';
import 'package:mob_app/screen/onbord_screen/onboard_screen.dart';
import 'package:mob_app/screen/splash/splash.dart';
import 'package:mob_app/util/themes.dart';
import 'package:provider/provider.dart';
import 'provider/connectivity_provider.dart';
import 'screen/forgot_password/ForgotPass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => UserProvider(),),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: Signin(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: SignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: Homepage(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: Signin(),
        ),
      ],
      child:GetMaterialApp(
      theme: theme(),
      getPages: [
        GetPage(name: '/', page: () => const Splash()),
        GetPage(name: '/onboard', page: () => const OnboardingScreen()),
        GetPage(name: '/signin', page: () => Signin()),
        GetPage(name: '/signup', page: () => const SignUp()),
        GetPage(name: '/homepage', page: () => const Homepage()),
        GetPage(name: '/forgot_pass', page: () => const ForgotPass()),
        GetPage(name: '/otp', page: () => OtpScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/profile_edit', page: () => const ProfileEdit()),
      ],
    ) ,
    );

    
  }
}
