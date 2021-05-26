import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mori_breath/core/detail.dart';
import 'package:mori_breath/weather/AQIBar.dart';
import 'package:mori_breath/weather/UVBar.dart';
import '../models/Species.dart';
import 'tag.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class addMinusBtn extends StatefulWidget {
  final BuildContext mapContext;
  final GoogleMapController mapController;
  final Function getMarkers;
  final Function setMarkers;
  final String name_ch;
  final Tag tags;

  addMinusBtn(
      {Key key,
      @required this.tags,
      @required this.name_ch,
      @required this.getMarkers,
      @required this.setMarkers,
      @required this.mapController,
      @required this.mapContext})
      : super(key: key);

  @override
  _addMinusBtn createState() => _addMinusBtn();
}

class _addMinusBtn extends State<addMinusBtn> {
  bool added = false;
  String symbol = "+";

  @override
  void initState() {
    super.initState();
    if (widget.tags.contain(widget.name_ch)) {
      setState(() {
        symbol = "-";
        added = true;
      });
    } else {
      setState(() {
        symbol = "+";
        added = false;
      });
    }
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  int nowshow = 0;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(symbol, style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        if (added) {
          fetchSpecies(widget.name_ch).then((query_result) async {
            Map<String, Marker> tmp = widget.getMarkers();
            query_result.forEach((specie) {
              tmp.remove(specie.marker_id.toString());
              widget.setMarkers(tmp);
            });
          });
          setState(() {
            widget.tags.minusTagOffline(widget.name_ch);
            symbol = "+";
            added = false;
          });
        } else {
          fetchSpecies(widget.name_ch).then((query_result) async {
            Map<String, Marker> tmp = widget.getMarkers();
            final iconA = await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(0.3, 0.3)), 'assets/a.png');
            query_result.forEach((specie) {
              //  print(specie);
              final marker = Marker(
                markerId: MarkerId(specie.marker_id.toString()),
                position: LatLng(specie.Latitude, specie.Longitude),
                infoWindow: InfoWindow(
                  title: specie.name_ch,
                  snippet: specie.Location,
                ),
                icon: iconA,
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: widget.mapContext,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, setState) =>
                                Container(
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
                                                    image:DecorationImage(image: AssetImage('assets/material/${specie.name_ch}.jpg',),fit: BoxFit.cover)),
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
                                                  Text(specie.name_ch,style: TextStyle(fontSize: 24),),
                                                  Divider(),
                                                  Text("123"),
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
                                            name: specie.name_ch,
                                          ),
                                            Divider(),
                                            SpeciesPhoto(
                                              name: specie.name_ch,
                                            )],),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              UVBar(uv_value: 5),
                                              AQIBar(aqi_value: 5),
                                              SizedBox(height: 20)
                                            ],
                                          ),
                                        )
                                      ])
                                    ],
                                  ),
                                ));
                      });
                },
              );
              tmp[specie.marker_id.toString()] = marker;
              widget.setMarkers(tmp);
            });
          });
          setState(() {
            widget.tags.addTag(widget.name_ch);
            symbol = "-";
            added = true;
          });
        }
      },
    );
  }
}
