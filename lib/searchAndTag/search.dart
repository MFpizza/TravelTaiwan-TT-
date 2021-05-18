import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mori_breath/models/SpeciesType.dart';
import 'tag.dart';
import 'addMinusBtn.dart';

class SearchPage extends StatefulWidget {

  final BuildContext mapContext;
  final Tag tag;
  final Function getMarkers;
  final Function setMarkers;
  final GoogleMapController mapController;

  SearchPage({Key key, @required this.tag, @required this.getMarkers, @required this.setMarkers, @required this.mapController, @required this.mapContext}) : super(key: key);

  _SearchPage createState() => _SearchPage(tag: tag);
}

class _SearchPage extends State<SearchPage> {
  final Tag tag;

  _SearchPage({this.tag});
//  final FocusNode _focus = FocusNode();
  List<String> history = ['aa', '23'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                    flex: 2,
                    child: Stack(children: [
                      TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            autofocus: false,
                            decoration: InputDecoration(
                              prefixIcon:Icon(Icons.arrow_back_outlined),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightGreen,
                                  width: 4,
                                ),
                              ),
                              //                      prefixIcon: IconButton(
                              //                        icon: Icon(Icons.arrow_back_sharp),
                              //                        onPressed: () => Navigator.of(context).pop(),
                              //                      ),
                              contentPadding: EdgeInsets.all(16.0),
                              border: OutlineInputBorder(),
                              hintText: '搜尋想看的植物',
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return await fetchSpeciesType(pattern);
                          },
                          itemBuilder: (context, item) {
                            return ListTile(
                              title: Text(item.name_ch),
                              trailing: CircleAvatar(
                                child: addMinusBtn(tags: tag, name_ch: item.name_ch, setMarkers: widget.setMarkers, getMarkers: widget.getMarkers, mapController: widget.mapController, mapContext: widget.mapContext),
                                backgroundColor: Colors.black,
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            //debugPrint(suggestion.name_ch);
                          },
                          keepSuggestionsOnSuggestionSelected: true,
                          noItemsFoundBuilder: (BuildContext context) =>
                              ListTile(
                                title: Text("查無結果!"),
                              )
                      ),
                      InkWell(child:Container(
                        width: 40,
                        height: 50,
                        color:Colors.white10,
                        alignment: Alignment.centerLeft,
                      ),onTap: (){
                        Navigator.of(context).pop();},
                      ),
                    ])),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: CircleAvatar(
                        backgroundColor: Colors.lightGreen,
                        child: TextButton(
                            child: Text(
                              "#",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              setState(() {
                                tag.showPopWindows(context, widget.setMarkers, widget.getMarkers);
                              });
                            }))),
              ],
            ),
          )),
          Expanded(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
//                  color: Colors.redAccent,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "心情",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
//                      color: Colors.redAccent,
                      alignment: Alignment.center,
                      child: Text(
                        "今天想要甚麼旅程呢?",
                        style: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Container(
//                  color:Colors.black54,
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Text(
                                  "散心",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                              Container(
                                width: 20,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Text(
                                  "探索",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ],
                          )),
                    )
                  ]))),
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey))),
                height: MediaQuery.of(context).size.height / 1.8,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
//                  color: Colors.redAccent,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "最近",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        ListTile(
                          leading: Text(
                            "#",
                            style: TextStyle(fontSize: 20),
                          ),
                          title:
                              Text("element", style: TextStyle(fontSize: 15)),
                          trailing: CircleAvatar(
                            child: TextButton(
                              child: Text("-",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              onPressed: () => print("尚未時做"),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            "#",
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text("aa", style: TextStyle(fontSize: 15)),
                          trailing: CircleAvatar(
                            child: TextButton(
                              child: Text("+",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              onPressed: () => print("尚未時做"),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            "#",
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text("123", style: TextStyle(fontSize: 15)),
                          trailing: CircleAvatar(
                            child: TextButton(
                              child: Text("-",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              onPressed: () => print("尚未時做"),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
