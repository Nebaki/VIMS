import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Componets/Custom_Icons.dart';
import '../../../util/constants.dart';
import '../../../helper/keyboard.dart';
import '../../check_user/check_user.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? password;
  bool? remember = false;
  bool _passwordVisible = false;
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final List<String?> errors = [];

  void initState() {
    _loadUserEmailPassword();
    _passwordVisible = false;
    super.initState();
  }

  bool _isloading = false;

  LoginController loginController = Get.put(LoginController());

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
              SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Theme(
                    data: ThemeData(
                        unselectedWidgetColor:
                            Color.fromARGB(255, 8, 42, 47) // Your color
                        ),
                    child: Checkbox(
                        activeColor: kPrimaryColor,
                        value: remember,
                        onChanged: _handleRemeberme),
                  )),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => CheckUser(),
                      transition: Transition.downToUp,
                      duration: Duration(seconds: 2));
                },
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  setState(() {
                    loginController.phoneController = phoneController;
                    loginController.passController = passController;
                    _isloading = true;
                  });
                  loginController.login();
                }
              },
              child: _isloading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Loading"),
                        SizedBox(
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "Continue",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRemeberme(bool? value) {
    remember = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value!);
        prefs.setString('phone', phoneController.text);
        prefs.setString('password', passController.text);
      },
    );
    setState(() {
      remember = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load phone");
    try {
      SharedPreferences refs = await SharedPreferences.getInstance();
      var phone = refs.getString("phone") ?? "";
      var _password = refs.getString("password") ?? "";
      var _remeberMe = refs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(phone);
      print(_password);
      if (_remeberMe) {
        setState(() {
          remember = true;
        });
        phoneController.text = phone;
      }
    } catch (e) {
      print(e);
    }
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_passwordVisible,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          KeyboardUtil.hideKeyboard(context);
          return kPassNullError;
        } else if (value.length < 4) {
          KeyboardUtil.hideKeyboard(context);
          return kShortPassError;
        } else if (value.length >= 25) {
          KeyboardUtil.hideKeyboard(context);
          return kLongPassError;
        } else if (value.isNotEmpty) {
          KeyboardUtil.hideKeyboard(context);
        }
        return null;
      },
      controller: passController, //loginController.passController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {}
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          KeyboardUtil.hideKeyboard(context);
          return kPhoneNumberNullError;
        } else if (value.length < 10) {
          KeyboardUtil.hideKeyboard(context);
          return kShortphoneError;
        } else if (value.length > 10) {
          KeyboardUtil.hideKeyboard(context);
          return kLongphoneError;
        }
        KeyboardUtil.hideKeyboard(context);
        return null;
      },
      controller: phoneController,
      //  loginController.phoneController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: "phone",
        hintText: "0911111111",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(
          svgIcon: "assets/icons/Phone.svg",
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
