import 'package:flutter/material.dart';
import 'package:toasty/toasty.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: new RaisedButton(
            onPressed: () {
              Toasty.showToast(
                message: 'ali hoeinpoor',
                backgroundColor: Colors.black,
                fontColor: Colors.white,
                gravity: TOAST_GRAVITY.BOTTOM,
                length: TOAST_LENGTH.LENGTH_LONG,
              );
            },
            child: new Text('toast'),
          ),
        ),
      ),
    );
  }
}
