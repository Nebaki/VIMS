import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/auth/auth.dart';
import 'package:mob_app/controller/reset_pass.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../Componets/Custom_Icons.dart';
import '../../componets/loading_button.dart';
import '../../constants/constants.dart';
import '../../helper/keyboard.dart';
import '../../provider/connectivity_provider.dart';
import '../../util/themes.dart';

class ForgotPass extends StatefulWidget {
  ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  ResetPassController respass = Get.put(ResetPassController());
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  void signInUser() {
    respass.Reset(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Reset password",
              textAlign: TextAlign.end,
            ),
          ),
          body: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ForgotPassForm(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              )),
        );
      } else {
        return NoInternet();
      }
    });
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  String password = "";
  String? conform_password;

  ResetPassController resetpass = Get.put(ResetPassController());

  bool _passwordVisible = false;
  bool _RepasswordVisible = false;
  bool _isloading = false;
  void initState() {
    _passwordVisible = false;
    _RepasswordVisible = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                    resetpass.Reset(context: context);
                  }
                },
                child: _isloading ? LoadingButton() : ContinueButton()),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: !_passwordVisible,
      controller: resetpass.passController,
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
        if (resetpass.passController.text != value) {
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
}
