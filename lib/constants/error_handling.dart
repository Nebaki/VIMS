import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucess,
}) {
  print(response.body);
  switch (response.statusCode) {
    case 200:
      onSucess();
      break;
    case 404:
      print(response.toString());
      print(response.body.toString());
      showSnackBar(context, "Server error");
      break;
    case 401:
      showSnackBar(context, response.statusCode.toString());
      break;
    case 400:
      showSnackBar(context, "Old Password is incorrect");
      break;
    default:
      showSnackBar(context, response.statusCode.toString());
  }
}
