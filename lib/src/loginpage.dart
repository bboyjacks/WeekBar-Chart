import 'package:flutter/material.dart';
import 'authprovider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({this.signInCallback});
  final VoidCallback signInCallback;

  void _login(BuildContext context) {
    final auth = AuthProvider.of(context).auth;
    auth.signIn((currentUser){
      signInCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton(
            color: Colors.blue[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(30, 30)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 5,
                bottom: 15,
                left: 5
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(FontAwesomeIcons.google,
                    color: Colors.red[900],
                  ),
                  SizedBox(width: 20,),
                  Text("Log in",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(237, 96, 45, 1.0)
                    )
                  ),
                ],
              ),
            ),
            onPressed: (){
              _login(context);
            },
          )
        )
      )
    );
  }
  
}