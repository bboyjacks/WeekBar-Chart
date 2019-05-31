import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

import 'package:http/http.dart'
    show BaseRequest, Response, StreamedResponse;
import 'package:http/io_client.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signIn();
  Future<String> currentUser();
  Future<void> signOut();
}

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

class Auth implements BaseAuth {

  final googleSignInInstance = GoogleSignIn(scopes: [
    calendar.CalendarApi.CalendarReadonlyScope
  ]);
  
  @override
  Future<String> currentUser() {
    // TODO: implement currentUser
    return null;
  }

  @override signIn() {
    // TODO: implement signInWithEmailAndPassword
    return null;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    return null;
  }

}