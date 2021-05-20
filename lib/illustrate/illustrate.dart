import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mori_breath/core/detail.dart';
import 'package:mori_breath/member/member.dart';

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
  bool _initialized = false;
  bool _error = false;
  User user;
  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        user = FirebaseAuth.instance.currentUser;
      });
    } catch(e) {
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

  @override
  Widget build(BuildContext context) {
    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
    return Center(child: CircularProgressIndicator(),);
    }
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
                  return createContain(
                      species.elementAt(index), changeState, context);
                })));
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
                  builder: (BuildContext context) => Detail(
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
                          FirebaseFirestore.instance.collection('users').doc(user.email).update({a:myMap[a]});
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
                          FirebaseFirestore.instance.collection('users').doc(user.email).update({a:myMap[a]});
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
            createContain(a, changeState, context),
            VerticalDivider(),
            createContain(b, changeState, context),
          ],
        ),
      );
    });
  }
}
