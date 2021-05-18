import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mori_breath/member/member.dart';

import '../core/core.dart';

class Illustrate extends StatefulWidget {
  _Illustrate createState() => _Illustrate();
}

class _Illustrate extends State<Illustrate> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("圖鑑"),
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount: species.length,itemBuilder: (BuildContext context, int index){
        return createContainer(species.elementAt(index), changeState, context);
      })

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
