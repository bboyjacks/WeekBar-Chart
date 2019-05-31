// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/calendar/v3.dart' as calendar;

// import 'package:http/http.dart'
//     show BaseRequest, Response, StreamedResponse;
// import 'package:http/io_client.dart';
// import 'dart:async';

// class GoogleHttpClient extends IOClient {
//   Map<String, String> _headers;

//   GoogleHttpClient(this._headers) : super();

//   @override
//   Future<StreamedResponse> send(BaseRequest request) =>
//       super.send(request..headers.addAll(_headers));

//   @override
//   Future<Response> head(Object url, {Map<String, String> headers}) =>
//       super.head(url, headers: headers..addAll(_headers));

// }



// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final googleSignInInstance = GoogleSignIn(scopes: [
//     calendar.CalendarApi.CalendarReadonlyScope
//   ]);


//   @override
//   void initState() {

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _signIn() async {
//     await googleSignInInstance.signIn();
//     final start = DateTime.now().subtract(Duration(days: 4));
//     final end = DateTime.now().add(Duration(days: 1));
//     final authHeaders = await googleSignInInstance.currentUser.authHeaders;
//     final httpClient = GoogleHttpClient(authHeaders);
//     calendar.CalendarApi(httpClient).calendarList.list().then((onValue){
//       onValue.items.forEach((f) {
//         calendar.CalendarApi(httpClient).events.list(f.id, timeMin: start.toUtc(), timeMax: end.toUtc()).then((o){
//           o.items.forEach((e){
//             final startTime = e.start.dateTime;
//             print('''organinzer: ${e.organizer.displayName}, 
//                           title: ${e.summary},
//                           start: ${startTime?.month}/${startTime?.day}/${startTime?.year} ${startTime?.hour}:${startTime?.minute}''');
//           });
//         });
//       });
//     });
//   }

//   void _signOut() {
//     print("Sign out");
//     googleSignInInstance.signOut();
//   }
// }