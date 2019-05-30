import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  void signIn();
  void signOut();
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
  final scopes = [
    calendar.CalendarApi.CalendarEventsReadonlyScope,
    calendar.CalendarApi.CalendarReadonlyScope
  ];

  @override
  GoogleSignInAccount currentUser() {
    return signedInUser?.currentUser;
  }

  @override
  void signIn() async {
    signedInUser = GoogleSignIn(scopes: scopes);
    await signedInUser.signIn();
  }

  @override
  void signOut() {
    signedInUser.signOut();
  }

}