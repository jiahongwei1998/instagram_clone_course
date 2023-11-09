import 'package:flutter/material.dart';

extension DismissKeyobard on Widget {
  void dissmissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
