import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
    // TODO: implement initState
    super.initState();
    initialFirebase();
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Member(),
            Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                height: 70,
                child: Row(
                  children: [
                    TextButton(
                      child: Text(
                        "收藏",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        print("收藏");
                      },
                    ),
                    Text(
                      "成就",
                      style: TextStyle(fontSize: 20),
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
            Expanded(
              child:
                  //TODO 可以添加 listView Bar
                  Container(
                      color: Colors.white,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: lis.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
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
                                              image: AssetImage(
                                                  'assets/material/${lis.elementAt(index)}.jpg'),
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
                                            myMap[lis.elementAt(index)]
                                                ? IconButton(
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: Colors.red,
                                                      size: IconThemeData
                                                                  .fallback()
                                                              .size -
                                                          5,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        myMap[lis.elementAt(
                                                                index)] =
                                                            !myMap[
                                                                lis.elementAt(
                                                                    index)];
                                                      });
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: Colors.grey,
                                                      size: IconThemeData
                                                                  .fallback()
                                                              .size -
                                                          5,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        myMap[lis.elementAt(
                                                                index)] =
                                                            !myMap[
                                                                lis.elementAt(
                                                                    index)];
                                                      });
                                                    },
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Divider(),
                                  Text(lis.elementAt(index))
                                ],
                              ),
                            );
                          })),
            )
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
          notLogin = true;
        });
      } else {
        print('User is sign in!');
        setState(() {
          notLogin = false;
        });
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
  Member();

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
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(user.photoURL)),
                                  shape: BoxShape.circle),
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
      /*  DocumentSnapshot snapshot = await FirebaseFirestore.instance
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
              .set(myMap);
        } else if (snapshot.data().length < species.length) {
          //TODO 如果新增illustrate的東西要同步上去firebase
        } else {
          setState(() {
            user = (_user);
            notLogin = false;
            myMap = snapshot.data();
          });
        }*/
      }
    });
  }
}
