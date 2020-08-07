import 'package:flutter/material.dart';

class ButtonSelect extends StatelessWidget {
  ButtonSelect(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {},
      decoration: InputDecoration(
        //Focusしていないとき
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        //Focusしているとき
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.lightBlueAccent,
            width: 3.0,
          ),
        ),
        hintText: text,
        contentPadding: EdgeInsets.all(16.0),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
