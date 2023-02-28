import 'package:flutter/cupertino.dart';

class Buttons {
  static button(String text, Function onPressed) {
    return GestureDetector(
      child: Text(text),
      onTap: () {},
    );
  }
}
