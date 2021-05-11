import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 3,
                alignment: Alignment.center,
                color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.purpleAccent,
                              radius: 60,
                            ),
                            Container(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ID:12345678",
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(
                                  "沈淡",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
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
                              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context){return SettingPage();})),
                            )),
                      )
                    ],
                  ),
                )),
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
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black54),
              child: TextButton(
                child: Text(
                  "全部",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    //title: Text('AlertDialog Title'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                         TextButton(child:Center(child:Text("花")),),
                          TextButton(child:Center(child:Text("鳥")),),
                        ],
                      ),
                    ),
                   // actions: <Widget>[
                   //    TextButton(
                   //      child: Text('Approve'),
                   //      onPressed: () {
                   //        Navigator.of(context).pop();
                   //      },
                   //    ),
                   //  ],
                  );
                },),
              ),
            ),
            Expanded(
              child:
              //TODO 可以添加 listView Bar
              Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.width / 2.8,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.yellow,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
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
                          padding: EdgeInsets.all(10),
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
                          padding: EdgeInsets.all(10),
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
                  )),
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
