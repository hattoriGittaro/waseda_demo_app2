import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waseda_demo_app2/screens/posting_screen.dart';
import 'package:waseda_demo_app2/screens/registration_screen.dart';
import 'package:flushbar/flushbar.dart';
import '../constans.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email;

  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9C072B),
        title: Text('ログイン画面'),
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
                  child: Text('ログイン'),
                  onPressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostingScreen()));
                      }
                    } catch (e) {
                      Flushbar(
                        message: 'ログインに失敗しました',
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.all(8),
                        borderRadius: 8,
                        duration: Duration(seconds: 2),
                      )..show(context);
//                      showDialog(
//                        context: context,
//                        builder: (BuildContext context) {
//                          return AlertDialog(
//                            elevation: 24.0,
//                            title: Text('ログインできません'),
//                            actions: <Widget>[
//                              FlatButton(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(10.0),
//                                ),
//                                child: Text('やり直す'),
//                                onPressed: () {
//                                  Navigator.of(context).pop();
//                                },
//                              ),
//                            ],
//                          );
//                        },
//                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: FlatButton(
                  child: Text(
                    '新規登録する',
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegistrationScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
              Text(
                '授業レビューをするには新規登録が必要です',
                style: TextStyle(
                  fontSize: 10.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
