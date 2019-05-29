import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

import 'package:http/http.dart'
    show BaseRequest, Response, StreamedResponse;
import 'package:http/io_client.dart';

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));

}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _googleSignInObject = new GoogleSignIn(
    scopes: [
      calendar.CalendarApi.CalendarReadonlyScope
    ]
  );

  void _googleSignIn() async {
    await _googleSignInObject.signIn();
    final authHeaders = await _googleSignInObject.currentUser.authHeaders;
    final googleClient = GoogleHttpClient(authHeaders);
    calendar.CalendarApi(googleClient).calendarList.list(maxResults: 10).then(
      (onvalue) {
        onvalue.items.forEach((item){
          print(item.toJson());
        });
      }
    );
  }

  void _googleSignOut() {
    print("Signed out");
    _googleSignInObject.signOut();
  }

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
          child: SizedBox.expand( 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: _googleSignIn,
                    child: Text("sign in")
                  ),
                  SizedBox(height: 10, width: 20,),
                  RaisedButton(
                    onPressed: _googleSignOut,
                    child: Text("sign out")
                  )
                ]
            )
          )
        ),
      ),
    );
  }
}