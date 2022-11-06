import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../Componets/Custom_Icons.dart';
import '../../../Componets/Form_err.dart';
import '../../../Componets/defaualt_button.dart';
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
  String? firstName;
  String? lastName;
  String? Phone;
  String? gender;
  bool remember = false;
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          const SizedBox(height: 10),
          buildLastNameFormField(),
          const SizedBox(height: 10),
          buildEmailFormField(),
          const SizedBox(height: 10),
          buildPhoneNumberFormField(),
          const SizedBox(height: 10),
          buildPasswordFormField(),
          const SizedBox(height: 10),
          buildConformPassFormField(),
          const SizedBox(height: 10),
          FormError(errors: errors),
          const SizedBox(height: 20),
          DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  // if all are valid then go to success screen;
                  // Navigator.pushNamed(context, HomeScreen.routeName);
                }
              },
              onPressed: () {
                Navigator.pushNamed(context, "/homepage");
              }),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => Phone = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Phone number",
            hintText: "Enter your Phone number",
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            border: inputDecorationTheme().border,
            enabledBorder: inputDecorationTheme().enabledBorder,
            focusedBorder: inputDecorationTheme().focusedBorder,
            contentPadding: inputDecorationTheme().contentPadding,
            floatingLabelBehavior:
                inputDecorationTheme().floatingLabelBehavior));
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
         border: inputDecorationTheme().border,
            enabledBorder: inputDecorationTheme().enabledBorder,
            focusedBorder: inputDecorationTheme().focusedBorder,
            contentPadding: inputDecorationTheme().contentPadding,
            floatingLabelBehavior:
                inputDecorationTheme().floatingLabelBehavior
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
         border: inputDecorationTheme().border,
            enabledBorder: inputDecorationTheme().enabledBorder,
            focusedBorder: inputDecorationTheme().focusedBorder,
            contentPadding: inputDecorationTheme().contentPadding,
            floatingLabelBehavior:
                inputDecorationTheme().floatingLabelBehavior
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
         border: inputDecorationTheme().border,
            enabledBorder: inputDecorationTheme().enabledBorder,
            focusedBorder: inputDecorationTheme().focusedBorder,
            contentPadding: inputDecorationTheme().contentPadding,
            floatingLabelBehavior:
                inputDecorationTheme().floatingLabelBehavior
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
         border: inputDecorationTheme().border,
            enabledBorder: inputDecorationTheme().enabledBorder,
            focusedBorder: inputDecorationTheme().focusedBorder,
            contentPadding: inputDecorationTheme().contentPadding,
            floatingLabelBehavior:
                inputDecorationTheme().floatingLabelBehavior
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        
        labelText: "Email",
        hintText: "Enter your email",
        suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
         border: inputDecorationTheme().border,
            enabledBorder: inputDecorationTheme().enabledBorder,
            focusedBorder: inputDecorationTheme().focusedBorder,
            contentPadding: inputDecorationTheme().contentPadding,
            floatingLabelBehavior:
                inputDecorationTheme().floatingLabelBehavior
      ),
    );
  }
}
