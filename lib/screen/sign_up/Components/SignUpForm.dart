import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/loading_button.dart';
import 'package:mob_app/constants/constants.dart';
import 'package:mob_app/controller/auth/auth.dart';
import '../../../componets/Custom_Icons.dart';
import '../../../helper/keyboard.dart';
import '../../../util/themes.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String password = "";
  String? conform_password;
  String? fullName;
  String? Phone;
  String? role;
  bool remember = false;
  bool _isloading = false;
  final List<String?> errors = [];

  AuthController registrationController = Get.put(AuthController());

  bool _passwordVisible = false;
  bool _RepasswordVisible = false;
  void initState() {
    // _passwordVisible = false;
    // _RepasswordVisible = false;
    setpassAndrepass();

    super.initState();
  }

  void setpassAndrepass() {
    setState(() {
      password = registrationController.passController.text;
    });
  }

  void signUpUser() {
    registrationController.signUpUser(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          const SizedBox(height: 10),
          // buildPhoneNumberFormField(),
          // const SizedBox(height: 10),
          buildEmailFormField(),
          const SizedBox(height: 10),
          buildPasswordFormField(),
          const SizedBox(height: 10),
          buildConformPassFormField(),
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
                    registrationController.signUpUser(context: context);
                  }
                },
                child: Obx(() => registrationController.isLoading.value
                    ? LoadingButton()
                    : ContinueButton())),
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => Phone = newValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return kPhoneNumberNullError;
          } else if (value.length < 10) {
            return kShortphoneError;
          } else if (value.length > 13) {
            return kLongphoneError;
          }
          return null;
        },
        maxLength: 10,
        controller: registrationController.phoneController,
        decoration: InputDecoration(
            labelText: "Phone number",
            hintText: "Enter your phone number",
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
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

  TextFormField buildPasswordFormField() {
    setState(() {
      password = registrationController.passController.text;
    });
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: !_passwordVisible,
      controller: registrationController.passController,
      onSaved: (newValue) {
        password = newValue!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 4) {
          return kShortPassError;
        } else if (value.length >= 25) {
          return kLongPassError;
        }

        return null;
      },
      maxLength: 25,
      decoration: InputDecoration(
        labelText: "Password",
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: !_RepasswordVisible,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 25,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        conform_password = value;
      },
      validator: (value) {
        if (password != value) {
          return kMatchPassError;
        } else if (value!.isEmpty) {
          return kPassNullError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm password",
          hintText: "Confirm your password",
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: registrationController.emailController,
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        if (value!.isNotEmpty) {
          if (!emailValidatorRegExp.hasMatch(value)) return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter your email address",
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
