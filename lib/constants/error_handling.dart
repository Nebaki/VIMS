import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucess,
}) {
  switch (response.statusCode) {
    case 200:
      onSucess();
      break;
    case 404:
      showSnackBar(context, "Server error");
      break;
    case 401:
      showSnackBar(context, "Invalid phone\/password");
      break;
    case 400:
      showSnackBar(context, "Old Password is incorrect");
      break;
      case 422:
      showSnackBar(context, "User already exist!");
      break;
    default:
      showSnackBar(context, response.statusCode.toString());
  }
}
