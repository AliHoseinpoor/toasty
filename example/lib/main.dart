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
            onPressed: () async {
              Toasty.showToast(
                message: 'this is a message',
                length: TOAST_LENGTH.LENGTH_SHORT,
                gravity: TOAST_GRAVITY.BOTTOM,
                fontColor: Colors.white,
                backgroundColor: Colors.grey.shade300,
                fontSize: 15,
              );
            },
            child: new Text('Toast'),
          ),
        ),
      ),
    );
  }
}
