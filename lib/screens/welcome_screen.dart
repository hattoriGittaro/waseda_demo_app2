import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waseda_demo_app2/model/posting_model.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostingModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: model.widgetOptions.elementAt(model.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.local_post_office),
                title: Text('review'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('search'),
              ),
            ],
            currentIndex: model.selectedIndex,
            selectedItemColor: Color(0xff9C072B),
            onTap: model.onItemTapped,
          ),
        );
      },
    );
  }
}
