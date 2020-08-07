import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waseda_demo_app2/screens/posting_screen.dart';
import 'package:waseda_demo_app2/screens/search_screen.dart';
import '../gakubu_data.dart';

class PostingModel extends ChangeNotifier {
  String gakubu = '';
  String lesson_name = ''; //キャメルケースにしないとダメだった
  String content = '';
  String unit = '';
  double evaluation = 3.0;
  double difficulty = 3.0;
  String selectedCurrency = '学部選択';

  Future addLessonToFirebase() async {
    if (gakubu.isEmpty) {
      throw ('入力してください');
    }
    if (lesson_name.isEmpty) {
      throw ('入力してください');
    }
    if (content.isEmpty) {
      throw ('入力してください');
    }
    if (unit.isEmpty) {
      throw ('入力してください');
    }
    Firestore.instance.collection('lessons').add({
      'gakubu': gakubu,
      'lesson_name': lesson_name,
      'content': content,
      'unit': unit,
      'timestamp': FieldValue.serverTimestamp(),
      'searchKey': setSearchParam(lesson_name),
      'evaluation': evaluation,
      'difficulty': difficulty,
    });
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  List<Text> getPickerItems() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return pickerItems;
  }

  void selectedText(selectedIndex) {
    selectedCurrency = currenciesList[selectedIndex];
    gakubu = this.selectedCurrency;
    notifyListeners();
  }

  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    PostingScreen(),
    SearchScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
