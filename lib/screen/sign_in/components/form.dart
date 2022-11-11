import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Componets/Custom_Icons.dart';
import '../../../componets/Form_err.dart';
import '../../../componets/defaualt_button.dart';
import '../../../util/constants.dart';
import '../../../helper/keyboard.dart';
import 'package:http/http.dart' as http;

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  bool _isloading = false;

  _login(String phone, String password) async {
    var url = Uri.parse('http://vims.afrimedtravel.com/api/auth/login');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {'phone': phone, 'password': password};
    try {
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data != null) {
          setState(() {
            _isloading = false;
          });
          print('Login successfully');
          Get.toNamed("/homepage");
        } else {
          _isloading = true;
          print('Response body: ${data.body}');
        }
      } else {
        Get.snackbar(
          "unauthorized",
          ".",
          icon: const CustomSurffixIcon(
            svgIcon: "assets/icons/Error.svg",
            color: Colors.red,
          ),
          snackPosition: SnackPosition.BOTTOM,
        );
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  TextEditingController PhoneController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          const SizedBox(height: 30),
          buildPasswordFormField(),
          const SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/forgot_pass");
                },
                //  => Navigator.pushNamed(
                //     context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                _login(PhoneController.text, PasswordController.text);
              }
            },
            onPressed: () {
              //
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: false,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          KeyboardUtil.hideKeyboard(context);
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          KeyboardUtil.hideKeyboard(context);
          addError(error: kShortPassError);
          return "";
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        } else if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        return null;
      },
      controller: PasswordController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          KeyboardUtil.hideKeyboard(context);
          addError(error: kPhoneNumberNullError);
          return "";
        }
        KeyboardUtil.hideKeyboard(context);
        return null;
      },
      controller: PhoneController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "Phone",
        hintText: "Enter your Phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(
          svgIcon: "assets/icons/Phone.svg",
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
