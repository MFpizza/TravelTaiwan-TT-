import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mori_breath/searchAndTag/search.dart';
import 'activity/activity.dart';
import 'searchAndTag/tag.dart';
import 'package:animations/animations.dart';
import 'page/firstPage.dart';
import 'member/member.dart';import 'illustrate/illustrate.dart';
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
    target: LatLng(23.796298894661422, 121.01559192402948),
    zoom:7.9746,
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

  Map<String, Marker> _markers = {};
  GoogleMapController _mapController;

  Map<String, Marker> getMarkers() {
    return _markers;
  }

  void setMarkers(Map<String, Marker> markers) {
    setState(() {
      _markers = markers;
    });
  }

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
            icon: Icon(Icons.book),
            label: '圖鑑',
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
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '活動',
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
    Illustrate(),
    mapPage(context),
    MemberPage(),
    Activity(),
  ];}



  Widget mapPage(BuildContext context) {

    BuildContext mapContext = context;

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
                    return SearchPage(tag: tag, getMarkers: getMarkers, setMarkers: setMarkers, mapController: _mapController, mapContext: mapContext);
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
                            tag.showPopWindows(context, setMarkers, getMarkers);
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
    setState(() {
      _mapController = controller;
    });
  }


}
