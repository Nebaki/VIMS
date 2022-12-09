import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RowText extends StatelessWidget {
  RowText({required this.text, this.textstyle});
  String text;
  final TextStyle? textstyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(text,
            style: TextStyle(color: KbalckColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ColumnText extends StatelessWidget {
  ColumnText({required this.text, this.textstyle});
  String text;
  final TextStyle? textstyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,
          style:
              TextStyle(color: KlighyBlackColor, fontWeight: FontWeight.bold)),
    );
  }
}
