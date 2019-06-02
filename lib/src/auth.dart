import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'daterange.dart';
import '../barchart/dataseries.dart';

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

class GoogleCalendarApi {
  static Future<calendar.CalendarList> getCalendarListByDateRange(DateRange dateRange) async {
    final authHeaders = await dateRange.auth.currentUser().authHeaders;
    final googleClient = GoogleHttpClient(authHeaders);
    final calList = await calendar.CalendarApi(googleClient).calendarList.list();
    return calList;
  }

  static Future<DataSeries> getCalendarEventsByDateRange(
    String calendarId, 
    DateRange dateRange) async {
    
    final authHeaders = await dateRange.auth.currentUser().authHeaders;
    final googleClient = GoogleHttpClient(authHeaders);
    final eventsList = await calendar.CalendarApi(googleClient).events.list(
      calendarId,
      timeMin: dateRange.start.toUtc(),
      timeMax: dateRange.end.toUtc()
    );
    print("calendar: ${eventsList.summary} -> Num events: ${eventsList.items.length}");
    return DataSeries();
  }

  static DataSeries _makeDataSeries(calendar.Events events) {
    return DataSeries();
  }
}