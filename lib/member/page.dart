import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MemberPage extends StatefulWidget{
  _MemberPage createState()=> _MemberPage();
}

class _MemberPage extends State<MemberPage>{

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.brown,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              alignment: Alignment.center,
              color: Colors.blue,
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
                padding: EdgeInsets.all(10),
                color: Colors.white,
                height: 100,
                child: Row(
                  children: [
                    TextButton(
                      child: Text(
                        "收藏",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        print("收藏");
                      },
                    ),
                    Text(
                      "成就",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                )),
            Expanded(
              child: Container(
                  color: Colors.red,
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
    );
  }


  Future<void> initialFirebase() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen((User _user) async {
      if (_user == null) {
        print('User is currently signed out!');
      } else {
        print('User is sign in!');
      }
    });
  }

}
