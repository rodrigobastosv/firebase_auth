import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste/signin_page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                  validator: (email) => email.isEmpty || email == '' ? 'Campo inválido' : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  onSaved: (password) => _password = password,
                  validator: (password) => password.isEmpty || password == '' ? 'Campo inválido' : null,
                ),
                SizedBox(height: 12),
                RaisedButton(
                  child: Text('Cadastrar'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
                      _formKey.currentState.reset();
                    } else {
                      print('form inválido');
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SigninPage()));
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
