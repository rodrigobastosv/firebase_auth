import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'welcome_page.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onSaved: (email) => _email = email,
                  validator: (email) =>
                      email.isEmpty || email == '' ? 'Campo inválido' : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  onSaved: (password) => _password = password,
                  validator: (password) => password.isEmpty || password == ''
                      ? 'Campo inválido'
                      : null,
                ),
                SizedBox(height: 12),
                RaisedButton(
                  child: Text('Entrar'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      var authResult = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password);
                      if (authResult.user != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => WelcomePage(
                                  email: authResult.user.email,
                                )));
                        print(
                            'Usuário ${authResult.user.email} foi autenticado!');
                      } else {
                        print('Falha ao autenticar usuário');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
