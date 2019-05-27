import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
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
    Color fontColor,
    Color backgroundColor,
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

    if (fontColor == null &&
        backgroundColor == null &&
        defaultTargetPlatform == TargetPlatform.android) {
      fontColor = Colors.black;
      backgroundColor = Colors.grey.shade300;
    } else if (fontColor == null &&
        backgroundColor == null &&
        defaultTargetPlatform == TargetPlatform.iOS) {
      fontColor = Colors.white;
      backgroundColor = Colors.black.withOpacity(0.9);
    } else if (fontColor == null && defaultTargetPlatform == TargetPlatform.android) {
      fontColor = Colors.black;
    } else if (fontColor == null && defaultTargetPlatform == TargetPlatform.iOS) {
      fontColor = Colors.white;
    } else if (backgroundColor == null && defaultTargetPlatform == TargetPlatform.android) {
      backgroundColor = Colors.grey.shade300;
    } else if (backgroundColor == null && defaultTargetPlatform == TargetPlatform.iOS) {
      backgroundColor = Colors.black.withOpacity(0.9);
    }

    final Map<String, dynamic> datas = <String, dynamic>{
      'message': message,
      'length': toastLength,
      'gravity': toastGravity,
      'font_size': fontSize,
      'font_color': fontColor.value,
      'back_color': backgroundColor.value,
    };

    await _channel.invokeMethod('showToast', datas);
  }
}
