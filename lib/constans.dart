import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.all(16.0),
  //Focusしていないとき
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
  //Focusしているとき
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(
      color: Color(0xff9C072B),
      width: 3.0,
    ),
  ),
);
