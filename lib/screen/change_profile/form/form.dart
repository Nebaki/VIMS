import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/change_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Componets/Custom_Icons.dart';
import '../../../constants/constants.dart';
import '../../../controller/auth/auth.dart';
import '../../../helper/keyboard.dart';
import '../../../util/themes.dart';

class change_profile_form extends StatefulWidget {
  const change_profile_form({super.key});

  @override
  State<change_profile_form> createState() => _change_profile_formState();
}

class _change_profile_formState extends State<change_profile_form> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? phone;
  String _name = '';
  String _email = '';
  String _phone = '';
  String? email;
  bool _passwordVisible = false;

  bool _isloading = false;
  void initState() {
    _passwordVisible = false;
  }

  void changeProfil() {
    change_prof.change_profile(
      context: context,
    );
  }

  ChangeProfileController change_prof = Get.put(ChangeProfileController());
  var PhoneC = TextEditingController();
  void initial() async {
    SharedPreferences profileData = await SharedPreferences.getInstance();
    setState(() {
      _name = profileData.getString('name')!;
      _email = profileData.getString('email')!;
      _phone = profileData.getString('phone')!;
      PhoneC.text = _phone;
    });
  }

  void changepass() {
    change_prof.change_profile(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          buildFullNameFormField(),
          const SizedBox(height: 20),
          buildEmailFormField(),
          const SizedBox(height: 20),
          buildPhoneNumberFormField(),
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
                      _isloading = true;
                    });
                    change_prof.change_profile(context: context);
                  }
                },
                child: Obx(
                  () => change_prof.isLoading.value
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
                )),
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      controller: change_prof.emailController,
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

  TextFormField buildFullNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
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
      controller: change_prof.fullNameController,
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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phone = newValue,
        validator: (value) {
          if (value!.isEmpty) {
            KeyboardUtil.hideKeyboard(context);
            return kPhoneNumberNullError;
          } else if (value.length < 10) {
            KeyboardUtil.hideKeyboard(context);
            return kShortphoneError;
          } else if (value.length > 13) {
            KeyboardUtil.hideKeyboard(context);
            return kLongphoneError;
          }
          KeyboardUtil.hideKeyboard(context);
          return null;
        },
        controller: change_prof.phoneController,
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
}
