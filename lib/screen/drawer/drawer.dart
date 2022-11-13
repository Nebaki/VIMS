import 'package:flutter/material.dart';
import 'package:mob_app/screen/Profile/profile_screen.dart';
class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ProfileScreen(),
    );
  }
}
