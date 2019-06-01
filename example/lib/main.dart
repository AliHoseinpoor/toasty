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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Toasty'),
        ),
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: () async {
                  Toasty.cancel();
                },
                child: new Text('Cancel Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.showToast(
                    message: 'this is a message',
                    length: TOAST_LENGTH.LENGTH_SHORT,
                    gravity: TOAST_GRAVITY.BOTTOM,
                    fontSize: 15,
                  );
                },
                child: new Text('Bottom Short Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.showToast(
                    message: 'this is a message',
                    length: TOAST_LENGTH.LENGTH_LONG,
                    gravity: TOAST_GRAVITY.BOTTOM,
                    fontSize: 15,
                  );
                },
                child: new Text('Bottom Long Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.showToast(
                    message: 'this is a message',
                    fontSize: 15,
                    gravity: TOAST_GRAVITY.CENTER,
                  );
                },
                child: new Text('Center Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.showToast(
                    message: 'this is a message',
                    fontSize: 15,
                    gravity: TOAST_GRAVITY.TOP,
                  );
                },
                child: new Text('Top Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.showToast(
                    message: 'this is a message',
                    length: TOAST_LENGTH.LENGTH_SHORT,
                    gravity: TOAST_GRAVITY.BOTTOM,
                    fontColor: Colors.white,
                    backgroundColor: Colors.black,
                    fontSize: 18,
                  );
                },
                child: new Text('Custom Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.successToast(
                    message: 'this is a success message',
                    length: TOAST_LENGTH.LENGTH_SHORT,
                    gravity: TOAST_GRAVITY.BOTTOM,
                    fontSize: 17,
                    iconSize: 17,
                    iconColor: Colors.white,
                    fontColor: Colors.white,
                  );
                },
                child: new Text('Success Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.errorToast(
                    message: 'this is a error message',
                    length: TOAST_LENGTH.LENGTH_SHORT,
                    gravity: TOAST_GRAVITY.BOTTOM,
                    fontSize: 17,
                    iconSize: 17,
                    iconColor: Colors.white,
                    fontColor: Colors.white,
                  );
                },
                child: new Text('Error Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
              new RaisedButton(
                onPressed: () async {
                  Toasty.warningToast(
                    message: 'this is a warning message',
                    length: TOAST_LENGTH.LENGTH_SHORT,
                    gravity: TOAST_GRAVITY.BOTTOM,
                    fontSize: 17,
                    iconSize: 17,
                    iconColor: Colors.white,
                    fontColor: Colors.white,
                  );
                },
                child: new Text('Warning Toast'),
              ),
              new SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
