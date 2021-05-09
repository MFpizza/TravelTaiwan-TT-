import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class FirstPage extends StatefulWidget {
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  int _selectedIndex = 0;

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
              height: 60,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(child: FlutterLogo(size: 50)),
                  Text("排行綁"),
                ],
              )),
          Container(
              color: Colors.purpleAccent,
              padding: EdgeInsets.all(5),
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    color: Colors.red,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.green,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.orange,
                  ),
                ],
              )),
          Container(
              color: Colors.orange,
              height: 300,
              alignment: Alignment.center,
//                          padding: Padding,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 1.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red), color: Colors.white),
                child: Text("其他功能 Icon"),
              )),
          Container(
              height: 60,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(child: FlutterLogo(size: 50)),
                  Text("排行綁"),
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.width / 2.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.green),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.red)
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.width / 2.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.green),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.red)
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.width / 2.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.green),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.red)
                ],
              )),
        ],
      ),
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
          // GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), children: [
          //   Container(
          //       height: MediaQuery.of(context).size.width / 3,
          //       width: MediaQuery.of(context).size.width / 3,
          //       color: Colors.green),
          //   Container(
          //     width: MediaQuery.of(context).size.width / 10,
          //   ),
          //   Container(
          //       height: MediaQuery.of(context).size.width / 3,
          //       width: MediaQuery.of(context).size.width / 3,
          //       color: Colors.red)
          // ],),
          Container(
              height: MediaQuery.of(context).size.width / 2.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.green),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.red)
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.width / 2.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.green),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.red)
                ],
              )),
          Container(
            height: MediaQuery.of(context).size.width / 2.8,
            width: MediaQuery.of(context).size.width,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.green),
              Container(
                width: MediaQuery.of(context).size.width / 10,
              ),
              Container(
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.red)
            ]),
            // FutureBuilder(
            //   //future: users.doc(user.email).get(),
            //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //      print("error");
            //      return buildListForRecommend();
            //
            //     }
            //
            //     if (snapshot.connectionState == ConnectionState.done) {
            //
            //       return buildListForRecommend();
            //     }
            //
            //     return buildListForRecommend();
            //   },)
          )
        ],
      )
    ];
  }

  // Widget buildListForRecommend(){
  //   return ListView(children: [
  //     Container(
  //         height: MediaQuery.of(context).size.width / 2.8,
  //         width: MediaQuery.of(context).size.width,
  //         color: Colors.yellow,
  //         alignment: Alignment.center,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //                 height: MediaQuery.of(context).size.width / 3,
  //                 width: MediaQuery.of(context).size.width / 3,
  //                 color: Colors.green),
  //             Container(
  //               width: MediaQuery.of(context).size.width / 10,
  //             ),
  //             Container(
  //                 height: MediaQuery.of(context).size.width / 3,
  //                 width: MediaQuery.of(context).size.width / 3,
  //                 color: Colors.red)
  //           ],
  //         )),
  //     Container(
  //         height: MediaQuery.of(context).size.width / 2.8,
  //         width: MediaQuery.of(context).size.width,
  //         color: Colors.yellow,
  //         alignment: Alignment.center,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //                 height: MediaQuery.of(context).size.width / 3,
  //                 width: MediaQuery.of(context).size.width / 3,
  //                 color: Colors.green),
  //             Container(
  //               width: MediaQuery.of(context).size.width / 10,
  //             ),
  //             Container(
  //                 height: MediaQuery.of(context).size.width / 3,
  //                 width: MediaQuery.of(context).size.width / 3,
  //                 color: Colors.red)
  //           ],
  //         )),
  //     Container(
  //         height: MediaQuery.of(context).size.width / 2.8,
  //         width: MediaQuery.of(context).size.width,
  //         color: Colors.yellow,
  //         alignment: Alignment.center,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //                 height: MediaQuery.of(context).size.width / 3,
  //                 width: MediaQuery.of(context).size.width / 3,
  //                 color: Colors.green),
  //             Container(
  //               width: MediaQuery.of(context).size.width / 10,
  //             ),
  //             Container(
  //                 height: MediaQuery.of(context).size.width / 3,
  //                 width: MediaQuery.of(context).size.width / 3,
  //                 color: Colors.red)
  //           ],
  //         )),
  //   ],);
  // }

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
}
