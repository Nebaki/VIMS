import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/connection_checker/controller_binding.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme(),
      getPages: AppPages.routes,
      initialBinding: ControllerBinding(),
    );
  }
}
