import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/check_user.dart';
import 'package:mob_app/controller/otp.dart';

import '../Componets/Custom_Icons.dart';
import '../Componets/no_account_text.dart';
import '../constants/constants.dart';
import '../helper/keyboard.dart';
import 'package:http/http.dart' as http;
import '../util/api_endpoints.dart';
import '../util/themes.dart';
import 'check_user/component/form.dart';

class Test extends StatefulWidget {
  Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final formKey = GlobalKey<FormState>();
  String? phone;
  CheckUserController checkuser = Get.put(CheckUserController());
  var VerifyPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Forgot Password",
          textAlign: TextAlign.end,
        ),
      ),
      body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tell us your phone and relax",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  //////////////////////////////
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 10,
                          onSaved: (newValue) => phone = newValue,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return kPhoneNumberNullError;
                            } else if (value.length < 10) {
                              return kShortphoneError;
                            } else if (value.length > 15) {
                              return kLongphoneError;
                            }
                            return null;
                          },
                          controller: checkuser.phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: "Phone",
                            hintText: "Enter your phone",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: const CustomSurffixIcon(
                              svgIcon: "assets/icons/Phone.svg",
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                          height: 10,
                        ),
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
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                print(checkuser.phoneController.text);
                                checkuser.check_user();
                                // CheckUserController.check_user();
                              }
                            },
                            child:
                                //  Obx(
                                //   () => CheckUserController.isLoading.value
                                //       ? Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             Text("Loading"),
                                //             SizedBox(
                                //               height: 30,
                                //               child: CircularProgressIndicator(
                                //                 color: Colors.white,
                                //               ),
                                //             ),
                                //           ],
                                //         )
                                //       :
                                Text(
                              "Continue",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // ),
                        const SizedBox(height: 10),
                        const NoAccountText(),
                      ],
                    ),
                  )

//////////////////////////////////////////////////////////////////////

                  // CheckUserForm(),
                ],
              ),
            ),
          )),
    );
  }
}

// check user controller

class CheckUserController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  OtpController otp = Get.put(OtpController());
  RxString controllerText = ''.obs;
  var isLoading = false.obs;
  String replacedPhone = "";
  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      controllerText.value = phoneController.text;
    });
  }

  Future<void> check_user() async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 7));
      phoneController.text.startsWith('0')
          ? replacedPhone = phoneController.text.replaceFirst('0', '+251')
          : replacedPhone = phoneController.text;
      print(replacedPhone);
      var url = Uri.parse(
              ApiEndPoints.baseurl + ApiEndPoints.authendpoints.check_user)
          .replace(queryParameters: {
        'phone': replacedPhone,
      });
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final response = await http.get(url, headers: headers);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        if (data["status"] == true) {
          print(replacedPhone);
          otp.verifyPhone(replacedPhone);
          isLoading.value = false;
          print("++++++++++++++++123456789");
        } else {
          print("123456789");
          Get.rawSnackbar(message: data["message"]);
        }
      } else {
        print(response.body.toString());
        Get.rawSnackbar(message: data["message"]);
      }
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }
}
