import 'package:flutter/material.dart';
import 'package:mob_app/screen/change_password/component/form.dart';
class Change_pass extends StatefulWidget {
  const Change_pass({super.key});

  @override
  State<Change_pass> createState() => _Change_passState();
}

class _Change_passState extends State<Change_pass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("change password"),
      centerTitle:true ,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30,right: 30,top:50),
          child: Column(
            children: [
              const SizedBox(height: 20),
                            change_pass_form(),
                            const SizedBox(height: 20),
      
            ],
          ),
        ),
      ),
    );
  }
}