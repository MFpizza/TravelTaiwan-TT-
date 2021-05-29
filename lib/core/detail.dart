import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mori_breath/models/Species.dart';
import 'package:mori_breath/page/webView.dart';
import 'dart:io';

import 'package:mori_breath/weather/weather.dart';

class SpeciesPage extends StatelessWidget {
  final String name;

  SpeciesPage({this.name});

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.only(top: 120),
                    child: Container(
                      padding: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 30),
                          ),
                          Divider(),
                          Detail(
                            name: name,
                          ),
                          Divider(),
                          SpeciesPhoto(
                            name: name,
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
                              image: AssetImage('assets/material/$name.jpg'),
                              fit: BoxFit.cover))),
                )
              ],
            ),
          ]))
        ],
      ),
    );
  }
}

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
    //FirebaseFirestore firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Species')
                    .doc(name)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // print();
                    return Container(
                      padding: EdgeInsets.all(30),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black87),
                      child: Text(
                        snapshot.data.data()['介紹'],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: Text('前往wiki看更多'),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebViewExample(
                        url: "https://zh.wikipedia.org/zh-tw/${name}"))),
              ),
            )
          ],
        ));
  }
}

class SpeciesPhoto extends StatefulWidget {
  final String name;

  SpeciesPhoto({this.name});

  _SpeciesPhoto createState() => _SpeciesPhoto(name: name);
}

class _SpeciesPhoto extends State<SpeciesPhoto> {
  final String name;

  _SpeciesPhoto({this.name});

  Future<void> updatePhoto(_source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: _source);
    String filename = pickedFile.path.toString().split('/').last;
    File file = File(pickedFile.path);

    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref('Species/$name/' + filename)
        .putFile(file);
    String download = await snapshot.ref.getDownloadURL();
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('Species').doc(name).get();
    List<dynamic> lis = docSnapshot.data()['photo'];
    if (lis == null) lis = [];
    lis.add(download);
    FirebaseFirestore.instance
        .collection('Species')
        .doc(name)
        .update({'photo': lis});
  }

  Widget createRow(List<dynamic> urls) {
    // print(urls);
    List<Widget> lis = <Widget>[
      Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 50, bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: Text(
              '照片',
              style: TextStyle(fontSize: 24),
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 30),
            child: ElevatedButton(
              child: Text('上傳圖片'),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      content: Text(
                        "從相機或相片庫中選取",
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: <Widget>[
                        CupertinoButton(
                          child: Text("相機"),
                          onPressed: () {
                            updatePhoto(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoButton(
                          child: Text("相片庫"),
                          onPressed: () {
                            updatePhoto(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    ];
    //
    if (urls == null) {
      lis.add(Container(
        height: MediaQuery.of(context).size.width / 3,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text("尚未有圖片上傳"),
        ),
      ));
    }
    else {
      List<Widget> forRow = <Widget>[];
      for (int index=0; index < urls.length; index++) {
        forRow.add(Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(urls.elementAt(index).toString()),
                  fit: BoxFit.cover)),
        ));
        if ((index % 3 == 2 ) || (index == (urls.length - 1))) {
          // List<Widget> forRow2 = List.from()
          lis.add(Row(
            children: List.from(forRow),
          ));
          forRow.clear();
        }
      }
    }
   return Column(children: lis);
  }

  @override
  Widget build(BuildContext context) {
    //TODO 改成streambuilder
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Species')
            .doc(name)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // print(snapshot.data.data());
          if (!snapshot.hasData) {
            return Column(children: [
              Container(
                padding: EdgeInsets.only(left: 50, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '照片',
                  style: TextStyle(fontSize: 24),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ]);
          }
          try {
            // print('steam');
            return StatefulBuilder(builder: (context, StateSetter setState) {
              setState(() {});
              return createRow(snapshot.data.data()['photo']);
            });
          } catch (e) {
            return StatefulBuilder(builder: (context, StateSetter setState) {
              setState(() {});
              return createRow(null);
            });
          }
        });
  }
}

class MarkerBeTap extends StatefulWidget{
  final String name_ch;
  final String location;
  MarkerBeTap({this.name_ch,this.location});

  _MarkerBeTap createState()=>_MarkerBeTap(name_ch: name_ch,Location: location);
}

class _MarkerBeTap extends State{
  //final Species specie;
  _MarkerBeTap({this.name_ch,this.Location});
  final String name_ch;
  final String Location;
  int nowshow=0;
  List weather=null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
              height:
              MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: ListView(
                children: [
                  Container(
                    height:
                    MediaQuery.of(context).size.height *
                        0.25,
                    width:
                    MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              2,
                          height: MediaQuery.of(context)
                              .size
                              .height *
                              0.3,
                          child: Container(
                            width: MediaQuery.of(context)
                                .size
                                .width /
                                3,
                            height: MediaQuery.of(context)
                                .size
                                .width /
                                3,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    20),
                                image:DecorationImage(image: AssetImage('assets/material/${name_ch}.jpg',),fit: BoxFit.cover)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              2,
                          height: MediaQuery.of(context)
                              .size
                              .height *
                              0.3,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(name_ch,style: TextStyle(fontSize: 24),),
                              Text(Location,style: TextStyle(fontSize: 18,color: Colors.grey),),
                              Divider(),
                              Stack(children: [
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  alignment:Alignment.centerRight,
                                  width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  2,child: ElevatedButton(onPressed: ()=>print("前往"), child: Text("前往")),),
                               FutureBuilder(
                                 future: getWeather(Location),
                                 builder: (context,AsyncSnapshot<List>snapshot){

                                   if(snapshot.hasData){
                                     weather=snapshot.data;


                                     return  Container(
                                       padding: EdgeInsets.only(right: 10),
                                       alignment:Alignment.centerLeft,
                                     color: Colors.red,);
                                   }

                                 return  Container(
                                   padding: EdgeInsets.only(right: 10),
                                   alignment:Alignment.centerLeft,
                                   height: 50,
                                   width: MediaQuery.of(context)
                                       .size
                                       .width /
                                       2,);
                               })
                              ],)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,),
                  Container(
                      width:
                      MediaQuery.of(context).size.width,
                      height: 70,
                      child: Row(
                        children: [
                          TextButton(
                            child: Text(
                              "詳細資料",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  decoration: TextDecoration
                                      .underline,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                nowshow = 0;
                              });
                            },
                          ),
                          VerticalDivider(),
                          TextButton(
                            child: Text(
                              "天氣",
                              style:
                              TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              setState(() {
                                nowshow = 1;
                              });
                            },
                          ),
                        ],
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                      )),
                  IndexedStack(index: nowshow, children: [
                    Container(
                      width:
                      MediaQuery.of(context).size.width,
                      child: Column(children: [ Detail(
                        name: name_ch,
                      ),
                        Divider(),
                        SpeciesPhoto(
                          name: name_ch,
                        )],),
                    ),
                    Container(
                      width:
                      MediaQuery.of(context).size.width,
                      child: Weather(lis:weather),
                    )
                  ])
                ],
              ),
            );
  }

  Future<List> getWeather(String location) async {
    var url = Uri.parse(
        'https://ar3s.dev/weather/web-api?country=${location.substring(0, 3)}&district=${location.substring(3, 6)}');
    print('start get weather');
    var response = await get(url);
    print(response.body);
    Map<String, dynamic> map = jsonDecode(response.body);
    List lis = map.values.toList();
    // print(lis);
    // print('return');
    return lis;
  }
}