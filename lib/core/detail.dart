import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detail extends StatefulWidget {
  final String name;

  Detail({this.name});

  _Detail createState() => _Detail(name: name);
}

class _Detail extends State<Detail> {
  final String name;

  _Detail({this.name});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('Species').doc(name).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print();
            return Scaffold(
              appBar: AppBar(),
              body: Stack(
                children: [
                  Container(
                    color: Colors.grey,
                  ),
                  SingleChildScrollView(
                      child: Column(children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.height,
                    ),
                    Stack(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.only(top: 120),
                            child: Container(
                              padding: EdgeInsets.only(top: 70),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.all(30),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    //height: MediaQuery.of(context).size.height*0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black87),
                                    child: Text(
                                      snapshot.data.data()['介紹'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            )),
                        Align(
                          alignment: Alignment(0, -0.5),
                          child: Container(
                              //padding: EdgeInsets.all(5),
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/material/$name.jpg'),
                                      fit: BoxFit.cover))),
                        )
                      ],
                    ),
                  ]))
                ],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
