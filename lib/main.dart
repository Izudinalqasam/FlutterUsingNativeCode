import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:method_channle/pigeon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel("MyChannel");
  String message = "No message from native";
  String messagePigeon = "No message from native with pigeon";

  Future<void> callNative() async {
    var params = <String, dynamic>{"from": "flutter"};

    String messageFromNative = "No message from native";
    try {
      messageFromNative =
          await platform.invokeMethod("myNativeFunction", params);
      print(messageFromNative);
    } on PlatformException catch (e) {
      print("Error" + e.details);
      messageFromNative = e.details;
    }

    setState(() {
      message = messageFromNative;
    });
  }

  void callNativeWithPigeon() async {
    MessageRequest request = MessageRequest()..result = "Sunanda";
    Api api = Api();
    MessageReply reply = await api.sendMessage(request);

    setState(() {
      messagePigeon = reply.query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Method Channel Tutorial"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(messagePigeon),
            SizedBox(
              height: 100,
            ),
            Text(message),
            RaisedButton(
                child: Text("Call Native Function"),
                onPressed: () {
                  callNative();
                  callNativeWithPigeon();
                })
          ],
        ),
      ),
    );
  }
}
