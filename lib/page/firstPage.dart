import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mori_breath/illustrate/illustrate.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mori_breath/member/member.dart';
import 'package:mori_breath/core/core.dart';

class FirstPage extends StatefulWidget {
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  int _selectedIndex = 0;
  List<String> lis = ['薰衣草', '櫻花', '鬱金香'];

  void changeState(){
    setState(() {

    });
  }

  List<Widget> buildList(BuildContext context) {
    return <Widget>[
      ListView(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Text("排行榜")),
                Container(
                  width: MediaQuery.of(context).size.width / 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Text("推薦"))
              ],
            ),
          ),
          Container(
              //color: Colors.purpleAccent,
              // padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Swiper(
               // autoplay: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return orderContain(lis.elementAt(index), index);
                },
                viewportFraction: 0.4,
                scale: 0.7,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [createContainer('玫瑰',changeState,context), VerticalDivider(), createContainer('蓮花',changeState,context)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [createContainer('向日葵',changeState,context), VerticalDivider(), createContainer('蘭花',changeState,context)],
          ),
        ],
      ),
      Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Text("排行榜")),
                Container(
                  width: MediaQuery.of(context).size.width / 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Text("推薦"))
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: myMap.length,
                itemBuilder: (BuildContext context, int index) {
                  return createContainer(myMap.keys.elementAt(index),changeState,context);
                }),
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "LOGO",
          style: TextStyle(fontSize: 30),
        )),
      ),
      body: IndexedStack(index: _selectedIndex, children: buildList(context)),
    );
  }

  Widget orderContain(String a, int index) {
    return Stack(
      children: [
        createContainer(a,changeState,context),
        Container(
          //color: Colors.orangeAccent,
          alignment: Alignment.bottomLeft,
          child: Image(image:AssetImage('assets/${index+1}-01.png'),width: 90,height: 70,),
        ),
      ],
    );
  }

  // Widget containa(String a) {
  //   return Container(
  //     width: 170,
  //     height: 170,
  //     child: Column(
  //       children: [
  //         Stack(children: [
  //           Container(
  //             width: 130,
  //             height: 130,
  //             decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                     image: AssetImage('assets/material/$a.jpg'),
  //                     fit: BoxFit.cover)),
  //           ),
  //           Container(
  //             padding: EdgeInsets.all(5),
  //             width: 130,
  //             height: 130,
  //             alignment: Alignment.bottomRight,
  //             child: Container(
  //               //  color: Colors.orangeAccent,
  //               width: 40,
  //               height: 40,
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 children: [
  //                   FaIcon(
  //                     FontAwesomeIcons.solidHeart,
  //                     color: Colors.white,
  //                   ),
  //                   myMap[a]
  //                       ? IconButton(
  //                           icon: FaIcon(
  //                             FontAwesomeIcons.solidHeart,
  //                             color: Colors.red,
  //                             size: IconThemeData.fallback().size - 5,
  //                           ),
  //                           onPressed: () {
  //                             setState(() {
  //                               myMap[a] = !myMap[a];
  //                             });
  //                           },
  //                         )
  //                       : IconButton(
  //                           icon: FaIcon(
  //                             FontAwesomeIcons.solidHeart,
  //                             color: Colors.grey,
  //                             size: IconThemeData.fallback().size - 5,
  //                           ),
  //                           onPressed: () {
  //                             setState(() {
  //                               myMap[a] = !myMap[a];
  //                             });
  //                           },
  //                         )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ]),
  //         Divider(),
  //         Text(a)
  //       ],
  //     ),
  //   );
  // }
}
