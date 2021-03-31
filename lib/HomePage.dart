import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'myPainter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.967379, 121.2617269),
    zoom: 14.4746,
  );

  List<bool> selectBool = [false, false, false];
  int _selectedIndex = 2;

  List<Widget> list(BuildContext context) => <Widget>[
        // Home page
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: SafeArea(
                child: Container(
                    color: Colors.brown,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          color: Colors.green,
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              FlutterLogo(size: 50),
                              Text("motherFucApp")
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView(
                          children: [
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      color: Colors.white),
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
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.green),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.green),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.green),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.red)
                                  ],
                                )),
                          ],
                        )),
                      ],
                    )))),
        //地圖page
        Container(
            child: Stack(children: [
          GoogleMap(
            //  onTap: (){ FocusScope.of(context).unfocus();},
            mapType: MapType.normal,
            compassEnabled: false,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _onMapCreated,
          ),
          SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightGreen,
                            width: 4,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(16.0),
                        border: OutlineInputBorder(),
                        hintText: '搜尋想看的植物',
                      ),
                      controller: _chatController,
                      onSubmitted: _submitText, // 綁定事件給_submitText這個Function
                    )),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: CircleAvatar(
                        backgroundColor: Colors.lightGreen,
                        child: IconButton(
                            icon: Icon(
                              Icons.list,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showPopupWindow(
                                context,
                                offsetX: 80,
                                offsetY: 75,
                                //childSize:Size(240, 800),
                                gravity: KumiPopupGravity.rightTop,
                                //curve: Curves.elasticOut,
                                duration: Duration(milliseconds: 300),
                                bgColor: Colors.black.withOpacity(0),
                                onShowStart: (pop) {
                                  print("showStart");
                                },
                                onShowFinish: (pop) {
                                  print("showFinish");
                                },
                                onDismissStart: (pop) {
                                  print("dismissStart");
                                },
                                onDismissFinish: (pop) {
                                  print("dismissFinish");
                                },
                                onClickOut: (pop) {
                                  print("onClickOut");
                                },
                                onClickBack: (pop) {
                                  print("onClickBack");
                                },
                                childFun: (pop) {
                                  return StatefulBuilder(
                                      key: GlobalKey(),
                                      builder: (popContext, popState) {
                                        return Container(
                                            padding: EdgeInsets.all(10),
                                            height: (selectBool.length) *
                                                65.toDouble(),
                                            width: 200,
//                                            color: Colors.black54,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Column(
                                              children: [
                                                CheckboxListTile(
                                                  checkColor: Colors.black,
//                                                  activeColor: Colors.green,
                                                  title: Text(
                                                    "flower",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
//                                                  secondary: Icon(Icons.add),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  value: selectBool[0],
                                                  onChanged: (bool value) {
                                                    popState(() {
                                                      selectBool[0] = value;
                                                    });
                                                  },
                                                ),
                                                CheckboxListTile(
                                                  checkColor: Colors.black,
//                                                  activeColor: Colors.green,
                                                  title: Text(
                                                    "bird",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
//                                                  secondary: Icon(Icons.add),
                                                  value: selectBool[1],
                                                  onChanged: (bool value) {
                                                    popState(() {
                                                      selectBool[1] = value;
                                                    });
                                                  },
                                                ),
                                                CheckboxListTile(
                                                  checkColor: Colors.black,
//                                                  activeColor: Colors.green,
                                                  title: Text(
                                                    "tree",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
//                                                  secondary: Icon(Icons.add),
                                                  value: selectBool[2],
                                                  onChanged: (bool value) {
                                                    popState(() {
                                                      selectBool[2] = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ));
                                      });
                                },
                              );
                            }))),
                CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          print("沒作用");
                        })),
              ],
            ),
          )),
          Align(
              //TODO 弄成想要的形狀
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  height: 125,
                  width: MediaQuery.of(context).size.width / 2,
//                  color: Colors.red,
                  child: Stack(
                    children: [
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: Stack(children: [
                            Container(
//                                color: Colors.black,
                                alignment: Alignment.bottomCenter,
                                child: CustomPaint(
                                  size: Size(100, 100),
                                  painter: MyPainter(),
                                )),
                            Container(
//                              color: Colors.yellow,
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wb_sunny_outlined,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 10,
                                      height: 75,
                                    ),
                                    Text(
                                      "900°C",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                  ],
                                ))
                          ])),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.lightGreen,
                                border: Border.all(color: Colors.white)),
                            child: Text(
                              "中壢區",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ],
                  )))
        ])),

        // Member page
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Container(
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
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.green),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.green),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.green),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.red)
                                  ],
                                )),
                          ],
                        )),
                  )
                ],
              ),
            )),
      ];

  final TextEditingController _chatController = TextEditingController();

  void _submitText(String text) {
    print(text);
  }

  @override
  void initState() {
    super.initState();
  }

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    final icona = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(1, 1)), 'assets/a.png');
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: "櫻花",
            snippet: office.address,
          ),
          icon: icona,
        );
        _markers[office.name] = marker;
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: list(context).elementAt(_selectedIndex),
//      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//      floatingActionButton: Stack(
//        children: <Widget>[
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.end,
//            children: <Widget>[
//              Container(
//                width: 40,
//                height: 40,
//                child: FloatingActionButton(
//                  onPressed: _incrementCounter,
//                  tooltip: 'Increment', //點住會出現訊息
//                  child: Icon(Icons.menu),
//                ),
//              ),
//              Container(
//                width: 10,
//                height: 10,
//              ), // a space
//              Container(
//                width: 40,
//                height: 40,
//                child: FloatingActionButton(
//                  onPressed: _decremenrCounter,
//                  backgroundColor: Colors.red,
//                  tooltip: 'Increment',
//                  child: Icon(Icons.remove),
//                ),
//              ),
//              Container(width: 180, height: 60),
//              Container(
//                width: 40,
//                height: 40,
//                child: FloatingActionButton(
//                  onPressed: _incrementCounter,
//                  tooltip: 'Increment',
//                  child: Icon(Icons.menu),
//                ),
//              ),
//              Container(
//                width: 10,
//                height: 10,
//              ), // a space
//              Container(
//                width: 40,
//                height: 40,
//                child: FloatingActionButton(
//                  onPressed: _decremenrCounter,
//                  backgroundColor: Colors.red,
//                  tooltip: 'Increment',
//                  child: Icon(Icons.remove),
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '會員專區',
            backgroundColor: Colors.lightGreen,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
        onTap: _onItemTapped,
      ),
    );
  }
}
