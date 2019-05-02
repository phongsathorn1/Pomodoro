import 'package:flutter/material.dart';

Widget addSymetricMargin({Widget child, double horizontal = 0.0, double vertical = 0.0}) {
  return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: child);
}

textStyleMedium({double fontSize, Color color = Colors.white}) {
  return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: color);
}

textStyleRegular({double fontSize, Color color = Colors.white}) {
  return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w400, color: color);
}

textStyleLight({double fontSize, Color color = Colors.white}) {
  return _textStyle(fontSize: fontSize, fontWeight: FontWeight.w200, color: color);
}

_textStyle({double fontSize, fontWeight: FontWeight, Color color}) {
  return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight, fontFamily: 'Montserrat');
}


