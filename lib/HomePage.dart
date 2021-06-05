import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mori_breath/searchAndTag/addMinusBtn.dart';
import 'package:mori_breath/searchAndTag/search.dart';
import 'activity/activity.dart';
import 'core/detail.dart';
import 'searchAndTag/tag.dart';
import 'package:animations/animations.dart';
import 'page/firstPage.dart';
import 'member/member.dart';
import 'illustrate/illustrate.dart';
import 'package:geolocator/geolocator.dart';
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
    zoom: 7.9746,
  );

  Position currentPosition;

  var geolocator = Geolocator();

  void locatePosition() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng latlngPosition =
        LatLng(currentPosition.latitude, currentPosition.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latlngPosition,zoom:  7.9746);

    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  int _selectedIndex = 0;

  Tag tag;
  List<String> history = [];
  List<Widget> recent_child = [];

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

  bool drag = true;

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

  List<Widget> buildList(BuildContext context) {
    return <Widget>[
      FirstPage(),
      Illustrate(),
      mapPage(context),
      MemberPage(),
      Activity(),
    ];
  }

  BuildContext mapContext;
  void addHistory(name_ch) {
    setState( () {
      if(history.contains(name_ch)) {
        history.remove(name_ch);
      }
      history.insert(0,
          name_ch
      );
      recent_child.clear();
      for (var item in history) {
        recent_child.insert(0,
            ListTile(
              leading: Text(
                "#",
                style: TextStyle(fontSize: 20),
              ),
              title: Text(item),
              trailing: CircleAvatar(
                child: addMinusBtn(tags: tag, name_ch: item, setMarkers: setMarkers, getMarkers: getMarkers, mapController: _mapController, mapContext: mapContext, addHistory: addHistory),
                backgroundColor: Colors.black,
              ),
            )
        );
      }
    });
  }

  Widget mapPage(BuildContext context) {
    mapContext = context;

    return Container(
        child: Stack(children: [
      GoogleMap(
        //  onTap: (){ FocusScope.of(context).unfocus();},
        mapType: MapType.normal,
        compassEnabled: false,
        zoomControlsEnabled: true,
        myLocationEnabled: true,
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
                    return SearchPage(
                        tag: tag,
                        history: history,
                        recent_child: recent_child,
                        getMarkers: getMarkers,
                        setMarkers: setMarkers,
                        mapController: _mapController,
                        mapContext: mapContext,
                        addHistory: addHistory);
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
      dragBottom()
    ]));
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _mapController = controller;
    });
    locatePosition();
  }

  Widget dragBottom() {
    // print(getMarkers());
    List<Marker> lis = _markers.values.toList();
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.07,
      maxChildSize: 0.5,
      builder: (BuildContext context, ScrollController scrollController) {
        if (_markers.length == 0) {
          return Container(
            padding: EdgeInsets.all(50),
            child: Text('no result'),
          );
        }
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
          child: Column(children: [
            Center(child: Container(height:20,width:10,child:Icon(Icons.menu),)),
          Expanded(
               // height: MediaQuery.of(context).size.height*0.8,
                child:ListView.builder(
            controller: scrollController,
            itemCount: _markers.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.all(5),
                  child: ListTile(
                      leading: Image(
                          image: AssetImage(
                              'assets/material/${lis.elementAt(index).infoWindow.title}.jpg')),
                      title: Text('${lis.elementAt(index).infoWindow.title}'),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                        Text(lis.elementAt(index).infoWindow.snippet),
                        Text('距離: ${(Geolocator.distanceBetween(currentPosition.latitude, currentPosition.longitude, lis.elementAt(index).position.latitude, lis.elementAt(index).position.longitude).toInt().toDouble()/1000)} km')]),
                    onTap: (){
                       LatLng objectPosition=lis.elementAt(index).position;

                       CameraPosition cameraPosition = CameraPosition(target: objectPosition,zoom:14);

                       _mapController
                           .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                       _mapController.showMarkerInfoWindow(lis.elementAt(index).markerId);
                       showModalBottomSheet(
                           isScrollControlled: true,
                           context: context,
                           builder: (context) {
                             return MarkerBeTap(name_ch: lis.elementAt(index).infoWindow.title,location: lis.elementAt(index).infoWindow.snippet,position: lis.elementAt(index).position,);
                           });
                    },
                  ));
            },
          ))]),
        );
      },
    );
  }
}
