import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toasty/toasty.dart';

void main() {
  const MethodChannel channel = MethodChannel('toasty');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
  });
}
