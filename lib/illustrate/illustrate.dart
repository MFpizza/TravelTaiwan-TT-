import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mori_breath/member/member.dart';

class Illustrate extends StatefulWidget{
  _Illustrate createState()=>_Illustrate();
}

class _Illustrate extends State<Illustrate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("圖鑑"),
      ),
      body: ListView(
        children: [
          contain('櫻花','向日葵'),
          contain('玫瑰','薰衣草'),
          contain('蘭花','蓮花'),
          contain('鬱金香','蓮花'),
        ],
      ),
    );
  }

  Widget contain(String a, String b) {
    return Builder(builder: (context) {
      return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 170,
              height: 170,
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/material/$a.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 130,
                      height: 130,
                      alignment: Alignment.bottomRight,
                      child: Container(
                        //  color: Colors.orangeAccent,
                        width: 40,
                        height: 40,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.white,
                            ),
                            myMap[a]
                                ? IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.red,
                                size: IconThemeData.fallback().size - 5,
                              ),
                              onPressed: () {setState(() {
                                myMap[a] = !myMap[a];
                              });},
                            )
                                : IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.grey,
                                size: IconThemeData.fallback().size - 5,
                              ),
                              onPressed: () {setState(() {
                                myMap[a] = !myMap[a];
                              });},
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  Divider(),
                  Text(a)
                ],
              ),
            ),
            VerticalDivider(),

            Container(
              width: 170,
              height: 170,
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/material/$b.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 130,
                      height: 130,
                      alignment: Alignment.bottomRight,
                      child: Container(
                        //  color: Colors.orangeAccent,
                        width: 40,
                        height: 40,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.white,
                            ),
                            myMap[b]
                                ? IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.red,
                                size: IconThemeData.fallback().size - 5,
                              ),
                              onPressed: () {setState(() {
                                myMap[b] = !myMap[b];
                              });},
                            )
                                : IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.grey,
                                size: IconThemeData.fallback().size - 5,
                              ),
                              onPressed: () {setState(() {
                                myMap[b] = !myMap[b];
                              });},
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  Divider(),
                  Text(b)
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}