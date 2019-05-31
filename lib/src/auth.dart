import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

abstract class BaseAuth {
  void signIn([VoidCallback signInCallback(GoogleSignInAccount currentUser)]);
  void signOut(VoidCallback signOutCallback);
  GoogleSignInAccount currentUser(); 
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
  GoogleSignIn signedInUser;
  GoogleSignInAccount currentSignedInAccount;
  final scopes = [
    calendar.CalendarApi.CalendarEventsReadonlyScope,
    calendar.CalendarApi.CalendarReadonlyScope
  ];

  @override
  GoogleSignInAccount currentUser() {
    return currentSignedInAccount;
  }

  @override
  void signIn([VoidCallback signInCallback(GoogleSignInAccount currentUser)]) async {
    signedInUser = GoogleSignIn(scopes: scopes);
    signedInUser.signIn().then((user){ 
      currentSignedInAccount = user;
      signInCallback(currentSignedInAccount);
    });
  }

  @override
  void signOut(VoidCallback signOutCallback) {
    signedInUser.signOut().then((user){
      signOutCallback();
    });
  }

}