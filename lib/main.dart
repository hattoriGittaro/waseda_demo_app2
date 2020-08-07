import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waseda_demo_app2/screens/welcome_screen.dart';

import 'model/posting_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostingModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}
