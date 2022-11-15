import 'package:get/get.dart';
import 'package:mob_app/controller/check_user.dart';
import 'package:mob_app/screen/check_user/check_user.dart';
import 'package:mob_app/screen/onbord_screen/onboard_screen.dart';
import 'package:mob_app/screen/splash/splash.dart';
import 'package:mob_app/util/constants.dart';

import 'screen/Profile/profile_screen.dart';
import 'screen/forgot_password/ForgotPass.dart';
import 'screen/home/hompage.dart';
import 'screen/otp/otp.dart';
import 'screen/profile/components/profile_edit.dart';
import 'screen/sign_in/Signin.dart';
import 'screen/sign_up/Signup.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: '/', page: () => const Splash()),
    GetPage(name: '/onboard', page: () => const OnboardingScreen()),
    GetPage(name: '/signin', page: () => Signin()),
    GetPage(name: '/signup', page: () => const SignUp()),
    GetPage(name: '/homepage', page: () => const Homepage()),
    GetPage(name: '/check_user', page: () => CheckUser()),
    GetPage(name: '/forgot_pass', page: () => const ForgotPass()),
    GetPage(name: '/otp', page: () => OtpScreen()),
    GetPage(name: '/profile', page: () => ProfileScreen()),
    GetPage(name: '/profile_edit', page: () => const ProfileEdit()),
  ];
}
