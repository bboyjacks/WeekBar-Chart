import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bar Chart"),
        ),
        body: SafeArea(
          child: StartPage()
        ),
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  final ClientId clientId = ClientId("357926066084-rhm1hm673ihal0ere5v9u35t6pmr2e1r.apps.googleusercontent.com", "baEPaU-19Kev0nNM4B4JVCjr");
  final List<String> scopes = ["https://www.googleapis.com/auth/calendar.readonly"];


  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  http.Client client = new http.Client();
  Widget startWidget = Center(child: Text("Test"),);
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    startClientAuth();
    super.initState();
  }

  void startClientAuth() {
    obtainAccessCredentialsViaUserConsent(widget.clientId, widget.scopes, client, openWebview)
        .then((AccessCredentials credentials) {
      print("Authenticated");
      client.close();
    });
  }

  void openWebview(String url) {
    print(url);
    setState(() {
     startWidget = WebView(
      initialUrl: url,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
     );
    });
  }

  @override
  Widget build(BuildContext context) {
    return startWidget;
  }
}

class DebugContainer extends StatelessWidget {
  DebugContainer({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 1.0
        )
      ),
      child: child
    );
  }
}