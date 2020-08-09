import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waseda_demo_app2/screens/posting_screen.dart';

import '../constans.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String email;

  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9C072B),
        title: Text('新規登録'),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('image/userLogin.png'),
                backgroundColor: Color(0xff9C072B),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  cursorColor: Color(0xff9C072B),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: '早稲田メールアドレス',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xff9C072B),
                    ),
                  ),
                ),
              ),
              Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  cursorColor: Color(0xff9C072B),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'パスワード',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff9C072B),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 330,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text('新規登録'),
                  onPressed: () async {
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostingScreen()));
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
