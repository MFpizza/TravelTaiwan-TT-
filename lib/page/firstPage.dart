import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mori_breath/core/detail.dart';
import 'package:mori_breath/member/member.dart';
import 'package:mori_breath/illustrate/illustrate.dart';
import 'dart:math';

class FirstPage extends StatefulWidget {
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  int _selectedIndex = 0;
  List<String> lis = ['薰衣草', '櫻花', '鬱金香'];
  User user;

  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        user = FirebaseAuth.instance.currentUser;
      });
      FirebaseAuth.instance.authStateChanges().listen((User _user) async {
        user = (_user);
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void changeState() {
    setState(() {});
  }

  Widget createContain(String a, Function changeState, BuildContext context) {
    myMap.putIfAbsent(a, () => false);
    return Container(
      width: 170,
      height: 170,
      child: Column(
        children: [
          Stack(children: [
            InkWell(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/material/$a.jpg'),
                        fit: BoxFit.cover)),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SpeciesPage(
                        name: a,
                      ))),
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
                            onPressed: () {
                              if (user == null) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        content: Text(
                                          "請先進行登入才能收藏",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        actions: <Widget>[
                                          CupertinoButton(
                                            child: Text("知道了"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                myMap[a] = !myMap[a];
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.email)
                                    .update({"favorite": myMap});
                                changeState();
                              }
                            },
                          )
                        : IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.grey,
                              size: IconThemeData.fallback().size - 5,
                            ),
                            onPressed: () {
                              if (FirebaseAuth.instance.currentUser == null) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        content: Text(
                                          "請先進行登入才能收藏",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        actions: <Widget>[
                                          // CupertinoButton(
                                          //   child: Text("取消"),
                                          //   onPressed: () {
                                          //     Navigator.pop(context);
                                          //   },
                                          // ),
                                          CupertinoButton(
                                            child: Text("知道了"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                myMap[a] = !myMap[a];

                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.email)
                                    .update({"favorite": myMap});
                                changeState();
                              }
                            },
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
    );
  }

  int nowshow = 0;

  List<int> randomNum(int many) {
    int maxNum = species.length;
    Random random = Random();
    List<int> lis = [];
    for (int i = 0; i < many; i++) {
      int rNum = random.nextInt(maxNum);
      if (lis.contains(rNum)) {
        i--;
        continue;
      }
      lis.add(rNum);
    }
    return lis;
  }

  List<Widget> buildList(BuildContext context) {
    List<int> lis2 = randomNum(6);
    return <Widget>[
      FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Species')
              .orderBy("count", descending: true)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              //print(snapshot.data.docs.elementAt(0).id);
              return ListView(
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
                          return orderContain(
                              snapshot.data.docs.elementAt(index).id, index);
                        },
                        viewportFraction: 0.4,
                        scale: 0.7,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createContain(snapshot.data.docs.elementAt(4).id,
                          changeState, context),
                      VerticalDivider(),
                      createContain(snapshot.data.docs.elementAt(5).id,
                          changeState, context)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createContain(snapshot.data.docs.elementAt(6).id,
                          changeState, context),
                      VerticalDivider(),
                      createContain(snapshot.data.docs.elementAt(7).id,
                          changeState, context)
                    ],
                  ),
                ],
              );
            }
            return ListView(
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
                  height: MediaQuery.of(context).size.height - 50,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                  alignment: Alignment.center,
                )
              ],
            );
          }),
      //排行榜
      //推薦
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
                itemCount: lis2.length,
                itemBuilder: (BuildContext context, int index) {
                  return createContain(species.elementAt(lis2.elementAt(index)),
                      changeState, context);
                }),
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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
    return Container(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            createContain(a, changeState, context),
            Container(
              alignment: Alignment(-1.5,-1.2),
              width: 200,
              height: 200,
              child: Container(
                width: 90,
                height: 70,
                //color: Colors.orangeAccent,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/${index + 1}-01.png'),fit: BoxFit.cover
                )),
              ),
            )
          ],
        ));
  }
}
