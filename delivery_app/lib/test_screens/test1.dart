import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  StreamController<double> controller = StreamController<double>.broadcast();
  StreamSubscription<double> streamSubscription;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter demo",
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                  child: Text("Subscribe"),
                  color: Colors.yellow,
                  onPressed: () async {
                    getDelayedRandomValue().listen((value) {
                      print('Value from manualStream: $value');
                    });
                  }),
              MaterialButton(
                  child: Text("Emit Value"),
                  color: Colors.blue[200],
                  onPressed: () {
                    controller.add(12);
                  }),
              MaterialButton(
                  color: Colors.red[200],
                  child: Text("Unsubscribe"),
                  onPressed: () {
                    streamSubscription.cancel();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Stream<double> getDelayedRandomValue() async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield random.nextDouble();
    }
  }
}
