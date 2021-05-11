import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mori_breath/searchAndTag/search.dart';
import 'src/locations.dart' as locations;
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'searchAndTag/tag.dart';
import 'package:animations/animations.dart';
import 'page/firstPage.dart';
import 'member/member.dart';
//TODO 搜尋葉面 tag葉面 搜尋清單layout 地圖中間顯示地區

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
//  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.033398077340603, 121.56489870934207),
    zoom: 14.4746,
  );

  int _selectedIndex = 0;

  Tag tag;

  void _submitText(String text) {
    print(text);
  }

  @override
  void initState() {
    super.initState();
    tag = Tag();
  }

  final Map<String, Marker> _markers = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: buildList(context)),
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
  List<Widget> buildList(BuildContext context) {return <Widget>[
    FirstPage(),
    mapPage(context),
    MemberPage(),
  ];}



  Widget mapPage(BuildContext context) {
    return Container(
        child: Stack(children: [
      GoogleMap(
        //  onTap: (){ FocusScope.of(context).unfocus();},
        mapType: MapType.normal,
        compassEnabled: false,
        zoomControlsEnabled: true,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        mapToolbarEnabled: false,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: _onMapCreated,
        markers: _markers.values.toSet(),
      ),
      SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                flex: 2,
                child: OpenContainer(
                  closedBuilder: (context, action) {
                    return Stack(children: [
                      TextField(
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
                        onSubmitted: _submitText, // 綁定事件給_submitText這個Function
                      ),
                      Container(
                        height: 55,
                        color: Colors.white10,
                      ),
                    ]);
                  },
                  transitionDuration: const Duration(seconds: 1),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (context, action) {
                    return SearchPage(tag: tag);
                  },
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: TextButton(
                        child: Text(
                          "#",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          setState(() {
                            tag.showPopWindows(context);
                          });
                        }))),
//                CircleAvatar(
//                    backgroundColor: Colors.lightGreen,
//                    child: IconButton(
//                        icon: Icon(Icons.send, color: Colors.white),
//                        onPressed: () {
//                          print("沒作用");
//                        })),
          ],
        ),
      )),
    ]));
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
//    print(googleOffices);
    final iconA = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0.3, 0.3)), 'assets/a.png');
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
//        print(office.name);
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: "櫻花",
            snippet: office.address,
          ),
          icon: iconA,
          onTap: () {
            showPopupWindow(
              context,
//            offsetX: MediaQuery.of(context).size.width,
              offsetY: 60,
//              childSize: Size(300, 900),
              gravity: KumiPopupGravity.centerBottom,
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
                controller.hideMarkerInfoWindow(MarkerId(office.name));
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
                          height: MediaQuery.of(context).size.height / 4,
//                        width: 200,
//                                            color: Colors.black54,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.elliptical(50, 50)),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            children: [
                              Container(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
//                                width: 300,
//                                height: 100,
//                                color:Colors.blue,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage("assets/a.png"),
                                                fit: BoxFit.cover))),
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                        width: 200,
                                        height: 120,
//                                            color: Colors.yellow,
                                        child: Column(
//                                              mainAxisAlignment: MainAxisAlignment.center,
//                                              crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "櫻花",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                            Text(
                                              "addresssssssssssssssss",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 20,
                                                ),
                                                Icon(Icons.clear),
                                                Container(
                                                  width: 70,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () =>
                                                        print("button"),
                                                    child: Text("前往"))
                                              ],
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    });
              },
            );
          },
        );
        _markers[office.name] = marker;
      }
    });
  }


}
