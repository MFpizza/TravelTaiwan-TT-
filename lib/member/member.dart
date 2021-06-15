import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mori_breath/core/detail.dart';
import 'package:mori_breath/illustrate/illustrate.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mori_breath/member/setting.dart';

class MemberPage extends StatefulWidget {
  _MemberPage createState() => _MemberPage();
}

class _MemberPage extends State<MemberPage> {
  bool notLogin = true;

  @override
  void initState() {
    initialFirebase();
    super.initState();
  }

  final keyss = GlobalKey();

  User user;
  int nowShow = 0;
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
                  borderRadius: BorderRadius.circular(10),
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
          Text(a,style: TextStyle(fontSize: a.length>5?14:20),),
          Divider(),
        ],
      ),
    );
  }
  void changeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var lis = [];
    myMap.forEach((key, value) {
      if (value == true) {
        lis.insert(0, key);
      }
    });
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Member(),
            StatefulBuilder(
                key: keyss,
                builder: (context, chang) {
                  return Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text(
                                  "收藏",
                                  style: TextStyle(
                                      color:  nowShow == 0?Colors.red:Colors.blue,
                                      fontSize: nowShow == 0?25:20,
                                      decoration: nowShow == 0?TextDecoration.underline:null,
                                      fontWeight: nowShow == 0?FontWeight.bold:null),
                                ),
                                onPressed: () {
                                  chang(() {
                                    nowShow = 0;
                                  });
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "成就",
                                  style: TextStyle(
                                      color:  nowShow == 1?Colors.red:Colors.blue,
                                      fontSize: nowShow == 1?25:20,
                                      decoration: nowShow == 1?TextDecoration.underline:null,
                                      fontWeight: nowShow == 1?FontWeight.bold:null),
                                ),
                                onPressed: () {
                                  chang(() {
                                    nowShow = 1;
                                  });
                                },
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                      // Container(
                      //   width: 100,
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30),
                      //       color: Colors.black54),
                      //   child: TextButton(
                      //     child: Text(
                      //       "全部",
                      //       style: TextStyle(color: Colors.white, fontSize: 20),
                      //     ),
                      //     onPressed: () => showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //           //title: Text('AlertDialog Title'),
                      //           content: SingleChildScrollView(
                      //             child: ListBody(
                      //               children: <Widget>[
                      //                 TextButton(
                      //                   child: Center(child: Text("花")),
                      //                 ),
                      //                 TextButton(
                      //                   child: Center(child: Text("鳥")),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           // actions: <Widget>[
                      //           //    TextButton(
                      //           //      child: Text('Approve'),
                      //           //      onPressed: () {
                      //           //        Navigator.of(context).pop();
                      //           //      },
                      //           //    ),
                      //           //  ],
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          child: IndexedStack(index: nowShow, children: [
                            (user!=null)? MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child:GridView.builder(
                                // scrollDirection: Axis.horizontal,
                                // shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: lis.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return createContain(lis.elementAt(index), changeState, context);
                                  // return Container(
                                  //   width: 170,
                                  //   height: 170,
                                  //   child: Column(
                                  //     children: [
                                  //       Stack(children: [
                                  //         Container(
                                  //           width: 130,
                                  //           height: 130,
                                  //           decoration: BoxDecoration(
                                  //               image: DecorationImage(
                                  //                   image: AssetImage(
                                  //                       'assets/material/${lis.elementAt(index)}.jpg'),
                                  //                   fit: BoxFit.cover)),
                                  //         ),
                                  //         Container(
                                  //           padding: EdgeInsets.all(5),
                                  //           width: 130,
                                  //           height: 130,
                                  //           alignment: Alignment.bottomRight,
                                  //           child: Container(
                                  //             //  color: Colors.orangeAccent,
                                  //             width: 40,
                                  //             height: 40,
                                  //             child: Stack(
                                  //               alignment: Alignment.center,
                                  //               children: [
                                  //                 FaIcon(
                                  //                   FontAwesomeIcons.solidHeart,
                                  //                   color: Colors.white,
                                  //                 ),
                                  //                 myMap[lis.elementAt(index)]
                                  //                     ? IconButton(
                                  //                         icon: FaIcon(
                                  //                           FontAwesomeIcons
                                  //                               .solidHeart,
                                  //                           color: Colors.red,
                                  //                           size: IconThemeData
                                  //                                       .fallback()
                                  //                                   .size -
                                  //                               5,
                                  //                         ),
                                  //                         onPressed: () {
                                  //                           setState(() {
                                  //                             myMap[lis.elementAt(
                                  //                                     index)] =
                                  //                                 !myMap[lis
                                  //                                     .elementAt(
                                  //                                         index)];
                                  //                           });
                                  //                         },
                                  //                       )
                                  //                     : IconButton(
                                  //                         icon: FaIcon(
                                  //                           FontAwesomeIcons
                                  //                               .solidHeart,
                                  //                           color: Colors.grey,
                                  //                           size: IconThemeData
                                  //                                       .fallback()
                                  //                                   .size -
                                  //                               5,
                                  //                         ),
                                  //                         onPressed: () {
                                  //                           setState(() {
                                  //                             myMap[lis.elementAt(
                                  //                                     index)] =
                                  //                                 !myMap[lis
                                  //                                     .elementAt(
                                  //                                         index)];
                                  //                           });
                                  //                         },
                                  //                       )
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ]),
                                  //       Divider(),
                                  //       Text(lis.elementAt(index))
                                  //     ],
                                  //   ),
                                  // );
                                })): Container(
                              child: Center(
                                child: Text('尚未登入'),
                              ),
                            ),
                            (user != null)
                                ? FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.email)
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        // print(snapshot.data.data());
                                        int count = snapshot.data.data()['count'];
                                        return  MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child:ListView.builder(
                                            itemCount: 5,
                                            itemBuilder: (context, int index) {
                                              // print(index);
                                              double Denominator =
                                                  ((count / (index + 1) / 10)
                                                      .toDouble());
                                              double widtha =
                                                  ((MediaQuery.of(context).size.width -
                                                          180) *
                                                      Denominator);
                                              return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20, horizontal: 10),
                                                  height: 200,
                                                  width:
                                                      MediaQuery.of(context).size.width,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.pinkAccent[100],
                                                        borderRadius:
                                                            BorderRadius.circular(30)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/a.png'),
                                                                  fit: BoxFit.cover),
                                                            )),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(left: 20),
                                                          width: MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              160,
                                                          // color:Colors.red,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                '前往賞花${(index + 1) * 10}次',
                                                                style: TextStyle(
                                                                    fontSize: 20,
                                                                    color:
                                                                        Colors.white),
                                                              ),
                                                              Container(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                padding:
                                                                    EdgeInsets.all(5),
                                                                height: 30,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    180,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                30),
                                                                    color:
                                                                        Colors.white),
                                                                child: Container(
                                                                  height: 30,
                                                                  width: widtha,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                30),
                                                                    color: Colors
                                                                            .pinkAccent[
                                                                        200],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 5,
                                                              ),
                                                              Center(
                                                                  child: Text(
                                                                "$count/${(index + 1) * 10}",
                                                                style: TextStyle(
                                                                    color:
                                                                        Colors.white),
                                                              ))
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                            }));
                                      }
                                      return CircularProgressIndicator();
                                    })
                                : Container(
                                    child: Center(
                                      child: Text('尚未登入'),
                                    ),
                                  ),
                          ]))
                    ],
                  );
                })
          ],
        ),
      ),
    ));
  }

  Future<void> initialFirebase() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen((User _user) async {
      if (_user == null) {
        print('User is currently signed out!');
        setState(() {
          user = null;
          notLogin = true;
        });
      } else {
        print('User is sign in!');
        setState(() {
          user = _user;
          notLogin = false;
        });
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user.email)
            .get();
        if (snapshot.data() == null) {
          setState(() {
            user = (_user);
            notLogin = false;
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user.email)
              .set({"favorite": myMap, "count": 0});
        } else if (snapshot.data()['favorite'].length < species.length) {
          //TODO 如果新增illustrate的東西要同步上去firebase
        } else {
          setState(() {
            user = (_user);
            notLogin = false;
            myMap = snapshot.data()['favorite'];
            keyss.currentState.setState(() {});
          });
        }
      }
    });
  }
}

class Favorite {}

Map<String, dynamic> myMap = {
  "玫瑰": false,
  "薰衣草": false,
  "向日葵": false,
  "蘭花": false,
  "蓮花": false,
  "櫻花": false,
  "鬱金香": false,
};

class Member extends StatefulWidget {
  _Member createState() => _Member();
}

class _Member extends State<Member> {
  bool notLogin = true;

  initState() {
    super.initState();
    initialFirebase();
  }

  User user;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        alignment: Alignment.center,
        color: Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                !notLogin
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VerticalDivider(),
                            user.photoURL != null
                                ? Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(user.photoURL)),
                                        shape: BoxShape.circle),
                                  )
                                : Container(
                                    width: 120,
                                    height: 120,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(Icons.person),
                                  ),
                            VerticalDivider(),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hi! ",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                                Text(
                                  user.displayName,
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                )
                              ],
                            ))
                          ],
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'not login',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SignInButton(
                                Buttons.Google,
                                onPressed: () async {
                                  print(await signInWithGoogle());
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.black87,
                        ),
                        onPressed: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SettingPage();
                        })),
                      )),
                )
              ],
            )));
  }

  Future<UserCredential> signInWithGoogle() async {
    //TODO 可用但資料庫得處理
    //   // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> initialFirebase() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen((User _user) async {
      if (_user == null) {
        print('User is currently signed out!');
        setState(() {
          notLogin = true;
        });
      } else {
        print('User is sign in!');
        setState(() {
          user = (_user);
          notLogin = false;
        });
      }
    });
  }
}
