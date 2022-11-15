import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/registration.dart';
import 'package:mob_app/provider/user_provider.dart';
import '../../../componets/Custom_Icons.dart';
import '../../../componets/Form_err.dart';
import '../../../componets/defaualt_button.dart';
import '../../../models/user.dart';
import '../../../util/constants.dart';
import '../../../helper/keyboard.dart';
import '../../../util/themes.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  String? fullName;
  String? Phone;
  String? role;
  bool remember = false;
  bool _isloading = false;
  final List<String?> errors = [];

  RegistrationController registrationController =
      Get.put(RegistrationController());

  var items = [
    'company',
    'individual',
  ];
  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      CircularProgressIndicator(),
      Text(" Registering ... Please wait")
    ],
  );

  String? selectedRole;
  String? Role;
  bool _passwordVisible = false;
  bool _RepasswordVisible = false;
  void initState() {
    _passwordVisible = false;
    _RepasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          const SizedBox(height: 10),
          buildPhoneNumberFormField(),
          const SizedBox(height: 10),
          buildEmailFormField(),
          const SizedBox(height: 10),
          buildPasswordFormField(),
          const SizedBox(height: 10),
          buildConformPassFormField(),
          const SizedBox(height: 10),
          builRoleField(),
          const SizedBox(height: 10),
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
                    _isloading = true;
                  });
                  registrationController.register();
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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => Phone = newValue,
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
        controller: registrationController.phoneController,
        decoration: InputDecoration(
            labelText: "phone number",
            hintText: "0911111111",
            suffixIcon: const CustomSurffixIcon(
              svgIcon: "assets/icons/Phone.svg",
              color: kPrimaryColor,
            ),
            border: inputDecorationTheme().border,
            enabledBorder: inputDecorationTheme().enabledBorder,
            focusedBorder: inputDecorationTheme().focusedBorder,
            contentPadding: inputDecorationTheme().contentPadding,
            floatingLabelBehavior:
                inputDecorationTheme().floatingLabelBehavior));
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      onSaved: (newValue) => fullName = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
        } else if (value.length < 3) {
          return kNamelShortError;
        } else if (value.length > 50) {
          return kNamelLognError;
        }
        return null;
      },
      controller: registrationController.fullNameController,
      decoration: InputDecoration(
          labelText: "Full Name",
          hintText: "Enter your full name",
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
            color: kPrimaryColor,
          ),
          border: inputDecorationTheme().border,
          enabledBorder: inputDecorationTheme().enabledBorder,
          focusedBorder: inputDecorationTheme().focusedBorder,
          contentPadding: inputDecorationTheme().contentPadding,
          floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior),
    );
  }

  builRoleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:40.0),
          child: Text(
            "what is your role?",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
           padding: const EdgeInsets.only(left:30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Row(
                children: [
                  Radio(
                      value: "company",
                      groupValue: Role,
                      onChanged: (value) {
                        setState(() {
                          Role = value.toString();
                          registrationController.role = Role;
                        });
                      }),
                  Expanded(
                    child: Text('company'),
                  ),
                  Radio(
                      value: "individual",
                      groupValue: Role,
                      onChanged: (value) {
                        setState(() {
                          Role = value.toString();
                          registrationController.role = Role;
                        });
                      })
                ],
              )),
              Expanded(
                child: Text('individual'),
              ),
            ],
          ),
        )
      ],
    );

    // DropdownButtonFormField(
    //   decoration: InputDecoration(
    //       border: inputDecorationTheme().border,
    //       hintText: "Role",
    //       enabledBorder: inputDecorationTheme().enabledBorder,
    //       focusedBorder: inputDecorationTheme().focusedBorder,
    //       contentPadding: inputDecorationTheme().contentPadding,
    //       floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior),
    //   // hint: const Text("Role"),
    //   icon: const Padding(
    //     padding: EdgeInsets.only(left: 48.0),
    //     child: Icon(Icons.keyboard_arrow_down),
    //   ),
    //   iconSize: 24,
    //   isDense: true,
    //   items: items
    //       .map((String items) => DropdownMenuItem(
    //             child: Text(items),
    //             value: items,
    //           ))
    //       .toList(),
    //   onChanged: (value) {
    //     if (items.contains(value)) {
    //       setState(() {
    //         registrationController.role = value;
    //       });
    //     }
    //   },
    // );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: !_RepasswordVisible,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        conform_password = value;
      },
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
        } else if ((password != value)) {
          return kMatchPassError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Re-enter your password",
          suffixIcon: IconButton(
            icon: Icon(
              _RepasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _RepasswordVisible = !_RepasswordVisible;
              });
            },
          ),
          border: inputDecorationTheme().border,
          enabledBorder: inputDecorationTheme().enabledBorder,
          focusedBorder: inputDecorationTheme().focusedBorder,
          contentPadding: inputDecorationTheme().contentPadding,
          floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior),
    );
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
      controller: registrationController.passController,
      decoration: InputDecoration(
        labelText: "password",
        hintText: "Enter your password",
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
        border: inputDecorationTheme().border,
        enabledBorder: inputDecorationTheme().enabledBorder,
        focusedBorder: inputDecorationTheme().focusedBorder,
        contentPadding: inputDecorationTheme().contentPadding,
        floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      controller: registrationController.emailController,
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "Neba@gmail.com",
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/Mail.svg",
            color: kPrimaryColor,
          ),
          border: inputDecorationTheme().border,
          enabledBorder: inputDecorationTheme().enabledBorder,
          focusedBorder: inputDecorationTheme().focusedBorder,
          contentPadding: inputDecorationTheme().contentPadding,
          floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior),
    );
  }
}
