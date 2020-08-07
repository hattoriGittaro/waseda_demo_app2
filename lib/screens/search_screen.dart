import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeceff1),
      appBar: AppBar(
        backgroundColor: Color(0xff9C072B),
        title: Card(
          child: TextField(
            cursorColor: Color(0xffd24752),
            decoration: InputDecoration(
              fillColor: Colors.red,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              hintText: '授業名',
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? Firestore.instance
                .collection('lessons')
                .where('searchKey', arrayContains: name)
                .snapshots()
            : Firestore.instance.collection("lessons").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    //Firestoreにあるデータを取得
                    DocumentSnapshot data = snapshot.data.documents[index];

                    //Firestoreにあるevaluationデータを取得
                    final evaluationCount =
                        snapshot.data.documents[index]['evaluation'];

                    //Firestoreにあるdifficultyデータを取得
                    final difficultyCount =
                        snapshot.data.documents[index]['difficulty'];

                    //timestampを取得してdatetimeに変える
                    final timeStamp =
                        snapshot.data.documents[index]['timestamp'];
                    final d = timeStamp.toDate();

                    return Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                data['gakubu'],
                              ),
                              Text(
                                data['lesson_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                d.year.toString() +
                                    '/' +
                                    d.month.toString() +
                                    '/' +
                                    d.day.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '[内容]',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                data['content'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                            child: Divider(
                              height: 5.0,
                              thickness: 1.0,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '[単位]',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                data['unit'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                            child: Divider(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '内容評価' + data['evaluation'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    child: SmoothStarRating(
                                        allowHalfRating: false,
                                        starCount: 5,
                                        rating: evaluationCount,
                                        size: 15.0,
                                        isReadOnly: true,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.star_half,
                                        color: Color(0xffffd54f),
                                        borderColor: Color(0xffffd54f),
                                        spacing: 0.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '単位評価' + data['difficulty'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    child: SmoothStarRating(
                                        allowHalfRating: false,
                                        starCount: 5,
                                        rating: difficultyCount,
                                        size: 15.0,
                                        isReadOnly: true,
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
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
