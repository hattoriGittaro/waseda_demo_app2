import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waseda_demo_app2/model/posting_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:waseda_demo_app2/screens/welcome_screen.dart';

class PostingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostingModel>(
      create: (_) => PostingModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9C072B),
          title: Text('Waseda Review'),
        ),
        body: Consumer<PostingModel>(
          builder: (context, model, child) {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 300.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            model.selectedCurrency,
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: CupertinoPicker(
                                      backgroundColor: Color(0xffffebee),
                                      itemExtent: 32.0,
                                      //アイテムが選択された際に実行する関数
                                      onSelectedItemChanged: (selectedIndex) {
                                        model.selectedText(selectedIndex);
                                      },
                                      children: model.getPickerItems(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          onChanged: (text) {
                            model.lesson_name = text;
                          },
                          decoration: InputDecoration(
                            //Focusしていないとき
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            //Focusしているとき
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Color(0xff9C072B),
                                width: 3.0,
                              ),
                            ),
                            hintText: '授業名',
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          onChanged: (text) {
                            model.content = text;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            //Focusしていないとき
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            //Focusしているとき
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Color(0xff9C072B),
                                width: 3.0,
                              ),
                            ),
                            hintText: '内容',
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          onChanged: (text) {
                            model.unit = text;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            //Focusしていないとき
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            //Focusしているとき
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Color(0xff9C072B),
                                width: 3.0,
                              ),
                            ),
                            hintText: '単位',
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('内容'),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (starCount) {
                                      model.evaluation = starCount;
                                    },
                                    starCount: 5,
                                    rating: 3,
                                    size: 40.0,
                                    isReadOnly: false,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    color: Color(0xffffd54f),
                                    borderColor: Color(0xffffd54f),
                                    spacing: 0.0),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('単位'),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (starCount) {
                                      model.difficulty = starCount;
                                    },
                                    starCount: 5,
                                    rating: 3,
                                    size: 40.0,
                                    isReadOnly: false,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    color: Color(0xffffd54f),
                                    borderColor: Color(0xffffd54f),
                                    spacing: 0.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: 300,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text('投稿する'),
                          onPressed: () async {
                            try {
                              await model.addLessonToFirebase();
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 24.0,
                                    title: Text('投稿されました！'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WelcomeScreen()));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              Navigator.of(context).pop();
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 24.0,
                                    title: Text(e.toString()),
                                    actions: <Widget>[
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
