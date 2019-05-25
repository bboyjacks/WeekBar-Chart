import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() =>
  runApp(MyApp());

class MyApp extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );

    print('Hello: ${user.email}');
    return user;
  }

  void _signOut() {
    _auth.signOut();
  }
  
  @override
  Widget build(BuildContext conext) {
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
          child: Center(
            child: Column(
              children: [
                RaisedButton(
                  onPressed: _handleSignIn,
                  child: Text("Sign in")
                ),
                SizedBox(height: 20.0, width: 20,),
                RaisedButton(
                  onPressed: _signOut,
                  child: Text("Sign out")
                )
              ]
            )
          ),
        ),
      )
    );
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