import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/provider/user_provider.dart';
import 'package:mob_app/screen/home/hompage.dart';
import 'package:mob_app/screen/sign_in/signin.dart';
import 'package:mob_app/screen/sign_up/Signup.dart';
import 'package:mob_app/util/themes.dart';
import 'package:provider/provider.dart';
import 'provider/connectivity_provider.dart';
import 'routes.dart';

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
          child: const SignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: const Homepage(),
        ),
      ],
      child:GetMaterialApp(
      theme: theme(),
      getPages:AppPages.routes
    ) ,
    );

    
  }
}
