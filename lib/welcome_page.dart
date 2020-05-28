import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'signup_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Bem vindo $email'),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SignupPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
