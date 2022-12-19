import 'package:get/get.dart';
import 'package:mob_app/screen/check_user/check_user.dart';
import 'package:mob_app/screen/active_work_order/active_work_order.dart.dart';
import 'package:mob_app/screen/active_work_order/list_of_vehicle/vehicle.dart';
import 'package:mob_app/screen/vehicle_intake/list_of_vehicle/vehicleList.dart';
import 'package:mob_app/screen/work_order_history/list_of_vehicle/vehicleList.dart';
import 'package:mob_app/screen/splash/splash.dart';
import 'package:mob_app/screen/test.dart';
import 'screen/change_password/change_password.dart';
import 'screen/change_profile/change_profile.dart';
import 'screen/forgot_password/ForgotPass.dart';
import 'screen/otp/otp.dart';
import 'screen/profile/profile_view.dart';
import 'screen/sign_in/Signin.dart';
import 'screen/sign_up/Signup.dart';
import 'screen/work_order_history/work_order_history.dart';
import 'screen/phone_verify/phoneverify.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: '/', page: () => const Splash()),
    GetPage(name: '/signin', page: () => Signin()),
    GetPage(name: '/signup', page: () => const SignUp()),
    GetPage(
        name: '/work_order_history', page: () => work_order_history_screen()),
    GetPage(name: '/check_user', page: () => CheckUser()),
    GetPage(name: '/forgot_pass', page: () => ForgotPass()),
    GetPage(name: '/otp', page: () => OtpScreen()),
    GetPage(name: '/change_pass', page: () => Change_pass()),
    GetPage(name: '/update_profile', page: () => const change_profile()),
    GetPage(name: '/profile', page: () => profileView()),
    GetPage(name: '/verify_phone', page: () => Verify_phone_screen()),
    GetPage(name: '/test', page: () => Test()),
    GetPage(name: "/currentWorkOrder", page: () => current_work_order()),
    GetPage(name: "/vehicleList", page: () => VehicleList()),
    GetPage(
        name: "/vehicleListForVeihcleIntakeItem",
        page: () => VehicleListIntakePart()),
    GetPage(
        name: "/vehicleListForCurrentWorkorder",
        page: () => VehicleListOCurrentWorkOrder())
  ];
}
