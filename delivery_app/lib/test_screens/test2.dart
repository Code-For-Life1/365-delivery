import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Testing Web Sockets"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(child: Text("Loading...")),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.orange,
                        shadowColor: Colors.blue,
                        child: Container(
                          child: Column(
                            children: [
                              Text(snapshot.data[index].receiverFullName,
                                  style: TextStyle(color: Colors.red)),
                              Text(
                                  '${snapshot.data[index].id},${snapshot.data[index].city},${snapshot.data[index].street},${snapshot.data[index].floor},${snapshot.data[index].receiverPhoneNumber} '),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Text("Mark as Completed")),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )),
      ),
    );
  }
}
