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
      showSnackBar("Server error");
      break;
    case 401:
      showSnackBar("Invalid phone\/password");
      break;
    case 400:
      showSnackBar("Old Password is incorrect");
      break;
    case 422:
      showSnackBar("Error!");
      break;
    case 500:
      showSnackBar("User exist in this profile!");
      break;
    default:
      showSnackBar(response.body);
  }
}
