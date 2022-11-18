import 'package:flutter/material.dart';

import 'form/form.dart';

class change_profile extends StatefulWidget {
  const change_profile({super.key});

  @override
  State<change_profile> createState() => _change_profileState();
}

class _change_profileState extends State<change_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("update profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(
            children: [
              const SizedBox(height: 20),
              change_profile_form(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
