import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mori_breath/member/member.dart';

import '../core/core.dart';
List<String> species = [
  '燈稱花',
  '樹杞',
  '斑花青牛膽',
  '一枝黃花',
  '七葉一枝花',
  '大枝掛繡球',
  '大香葉樹',
  '杜虹花',
  '咖啡樹',
  '昆欄樹',
  '梅花草',
];
class Illustrate extends StatefulWidget {
  _Illustrate createState() => _Illustrate();
}

class _Illustrate extends State<Illustrate> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              appBar: AppBar(
                title: Text("圖鑑"),
              ),
              body: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: species.length,
                      itemBuilder: (BuildContext context, int index) {
                        return createContainer(
                            species.elementAt(index), changeState, context);
                      })));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(color: Colors.white,child: CircularProgressIndicator(),);
      },
    );

  }

  void changeState() {
    setState(() {});
  }

  Widget contain(String a, String b) {
    return Builder(builder: (context) {
      return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createContainer(a, changeState, context),
            VerticalDivider(),
            createContainer(b, changeState, context),
          ],
        ),
      );
    });
  }
}
