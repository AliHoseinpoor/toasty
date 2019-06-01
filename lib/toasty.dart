import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TOAST_LENGTH { LENGTH_SHORT, LENGTH_LONG }
enum TOAST_GRAVITY { BOTTOM, CENTER, TOP }

class Toasty {
  static const MethodChannel _channel = const MethodChannel('toasty');
  static String toastLength = 'short';
  static String toastGravity = 'bottom';

  static Future<void> cancel() async {
    await _channel.invokeMethod('cancel');
  }

  static Future<void> showToast({
    @required String message,
    TOAST_LENGTH length = TOAST_LENGTH.LENGTH_SHORT,
    TOAST_GRAVITY gravity = TOAST_GRAVITY.BOTTOM,
    double fontSize = 15.0,
    Color fontColor,
    Color backgroundColor,
    int timeInSecForIos = 1,
  }) async {
    toastLength = calculateLength(length);
    toastGravity = calculateGravity(gravity);

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
      'time': timeInSecForIos,
    };

    await _channel.invokeMethod('showToast', datas);
  }

  static Future<void> successToast({
    @required String message,
    TOAST_LENGTH length = TOAST_LENGTH.LENGTH_SHORT,
    TOAST_GRAVITY gravity = TOAST_GRAVITY.BOTTOM,
    Color fontColor = Colors.white,
    double fontSize = 14.0,
    int iconSize = 16,
    Color iconColor = Colors.white,
  }) async {
    toastLength = calculateLength(length);
    toastGravity = calculateGravity(gravity);

    final Map<String, dynamic> datas = <String, dynamic>{
      'message': message,
      'length': toastLength,
      'gravity': toastGravity,
      'font_size': fontSize,
      'font_color': fontColor.value,
      'icon_color': iconColor.value,
      'icon_size': iconSize,
    };

    await _channel.invokeMethod('successToast', datas);
  }

  static Future<void> errorToast({
    @required String message,
    TOAST_LENGTH length = TOAST_LENGTH.LENGTH_SHORT,
    TOAST_GRAVITY gravity = TOAST_GRAVITY.BOTTOM,
    double fontSize = 14.0,
    int iconSize = 16,
    Color fontColor = Colors.white,
    Color iconColor = Colors.white,
  }) async {
    toastLength = calculateLength(length);
    toastGravity = calculateGravity(gravity);

    final Map<String, dynamic> datas = <String, dynamic>{
      'message': message,
      'length': toastLength,
      'gravity': toastGravity,
      'font_size': fontSize,
      'font_color': fontColor.value,
      'icon_color': iconColor.value,
      'icon_size': iconSize,
    };

    await _channel.invokeMethod('errorToast', datas);
  }

  static Future<void> warningToast({
    @required String message,
    TOAST_LENGTH length = TOAST_LENGTH.LENGTH_SHORT,
    TOAST_GRAVITY gravity = TOAST_GRAVITY.BOTTOM,
    double fontSize = 14.0,
    int iconSize = 16,
    Color fontColor = Colors.white,
    Color iconColor = Colors.white,
  }) async {
    toastLength = calculateLength(length);
    toastGravity = calculateGravity(gravity);

    final Map<String, dynamic> datas = <String, dynamic>{
      'message': message,
      'length': toastLength,
      'gravity': toastGravity,
      'font_size': fontSize,
      'font_color': fontColor.value,
      'icon_color': iconColor.value,
      'icon_size': iconSize,
    };

    await _channel.invokeMethod('warningToast', datas);
  }

  static String calculateLength(TOAST_LENGTH length) =>
      length == TOAST_LENGTH.LENGTH_LONG ? 'long' : 'short';

  static String calculateGravity(TOAST_GRAVITY gravity){
    if (gravity == TOAST_GRAVITY.CENTER) {
      return 'center';
    } else if (gravity == TOAST_GRAVITY.TOP) {
      return 'top';
    }else{
      return 'bottom';
    }
  }
}
