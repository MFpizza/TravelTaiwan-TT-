import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../models/Species.dart';
import 'tag.dart';

class addMinusBtn extends StatefulWidget {

  final BuildContext mapContext;
  final GoogleMapController mapController;
  final Function getMarkers;
  final Function setMarkers;
  final String name_ch;
  final Tag tags;

  addMinusBtn({Key key, @required this.tags, @required this.name_ch, @required this.getMarkers, @required this.setMarkers, @required this.mapController, @required this.mapContext}) : super(key: key);

  @override
  _addMinusBtn createState() => _addMinusBtn();
}

class _addMinusBtn extends State<addMinusBtn> {

  bool added = false;
  String symbol = "+";

  @override
  void initState() {
    super.initState();
    if(widget.tags.contain(widget.name_ch)){
      setState(() {
        symbol = "-";
        added = true;
      });
    }
    else{
      setState(() {
        symbol = "+";
        added = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return TextButton(
      child: Text(symbol,
          style: TextStyle(
              fontSize: 20, color: Colors.white)),
      onPressed: () {
        if(added) {
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
        }
        else {
          fetchSpecies(widget.name_ch).then((query_result) async {
            Map<String, Marker> tmp = widget.getMarkers();
            final iconA = await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(0.3, 0.3)), 'assets/a.png');
            query_result.forEach((specie) {
              final marker = Marker(
                markerId: MarkerId(specie.marker_id.toString()),
                position: LatLng(specie.Latitude, specie.Longitude),
                infoWindow: InfoWindow(
                  title: specie.name_ch,
                  snippet: specie.Location,
                ),
                icon: iconA,
                onTap: () {
                  showModalBottomSheet(context: widget.mapContext, builder: (context) {
                    return Column(children: [
                      ListTile(
                        title: Text(specie.name_ch),
                        subtitle: Text(specie.name_sci),
                      ),
                    ],);
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
      } ,
    );
  }
}