import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

enum TOAST_LENGTH { LENGTH_SHORT, LENGTH_LONG }
enum TOAST_GRAVITY { BOTTOM, CENTER, TOP }

class Toasty {
  static const MethodChannel _channel = const MethodChannel('toasty');

  static Future<void> showToast({
    @required String message,
    TOAST_LENGTH length = TOAST_LENGTH.LENGTH_SHORT,
    TOAST_GRAVITY gravity = TOAST_GRAVITY.BOTTOM,
    double fontSize = 15.0,
    Color fontColor = Colors.white,
    Color backgroundColor = Colors.black,
    String fontTypeface,
  }) async {
    String toastLength = 'short';
    String toastGravity = 'bottom';

    if (length == TOAST_LENGTH.LENGTH_LONG) {
      toastLength = 'long';
    }

    if (gravity == TOAST_GRAVITY.CENTER) {
      toastGravity = 'center';
    } else if (gravity == TOAST_GRAVITY.TOP) {
      toastGravity = 'top';
    }

    final Map<String, dynamic> datas = <String, dynamic>{
      'message': message,
      'length': toastLength,
      'gravity': toastGravity,
      'font_size': fontSize,
      'font_color': fontColor,
      'back_color': backgroundColor,
      'type_face': fontTypeface,
    };

    await _channel.invokeMethod('showToast', datas);
  }
}
