import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'myPainter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.967379, 121.2617269),
    zoom: 14.4746,
  );

  int _selectedIndex = 0;
  List<Widget> list = [];

  final TextEditingController _chatController = TextEditingController();

  void _submitText(String text) {
    print(text);
  }

  @override
  void initState() {
    super.initState();
    list = [
      Container(
        color: Colors.brown,
      ),
      Container(
          child: Stack(children: [
        GoogleMap(
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
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            print("沒作用");
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
        Align( //TODO 弄成想要的形狀
          alignment: FractionalOffset.bottomCenter,
          child: CustomPaint(
            size: Size(200,100),
            painter: MyPainter(),
          )
        )
      ])),
      Container(
        color: Colors.brown,
      ),
    ];
  }
// 沒事
  int _counter = 0;
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
      body: list.elementAt(_selectedIndex),
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decremenrCounter() {
    setState(() {
      _counter--;
    });
  }
}
