import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Custome_text extends StatelessWidget {
  Custome_text({this.text, this.textstyle});
  final String? text;
  final TextStyle? textstyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Text(text!, style: TextStyle(color: kPrimaryColor)),
      ),
    );
  }
}
