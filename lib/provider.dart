import 'package:mob_app/provider/connectivity_provider.dart';
import 'package:mob_app/screen/forgot_password/ForgotPass.dart';
import 'package:mob_app/screen/sign_in/Signin.dart';
import 'package:mob_app/screen/sign_up/Signup.dart';
import 'package:provider/provider.dart';

class providers {
  providers._();
  static final provider_ = [
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
      child: ForgotPass(),
    ),
  ];
}
