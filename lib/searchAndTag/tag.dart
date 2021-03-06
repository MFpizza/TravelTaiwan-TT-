import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import '../models/Species.dart';

class Tag {
  List<String> list = [];
  void minusTag(int index,BuildContext context,Function popState) {
    popState((){list.removeAt(index);});
  }

  void minusTagOffline(String value) {
    list.removeAt(list.indexWhere((element2) => element2==value));
  }

  bool contain(String value) {
    if(list.indexWhere((element2) => element2==value) == -1)
      return false;
    else
      return true;
  }

  List<String> addTag(String value) {
    list.insert(0, value);
    return list;
  }

  int size() {
    return list.length;
  }
  List<String> nowHave(){
    return list;
  }

  void showPopWindows(BuildContext context, Function setMarkers, Function getMarkers) {
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
              List<Widget> lis= this.returnTagWidget(context,popState, setMarkers, getMarkers);
              return Container(
                //padding: EdgeInsets.all(10),
                  height: 350,
                  width: 200,
//                                            color: Colors.black54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: Colors.black)),
                  child:
                  Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),

                    child: Text(
                      "?????? #",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    alignment: Alignment.center,
                    height: 63,
                  ),
                  Container(
                    // color: Colors.red,
                      width: 200,
                      height: 285,
                      child:
                      MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child:
                          Scrollbar(
                              showTrackOnHover: true,
                              isAlwaysShown: true,
                              child:
                          ListView.builder(
                      itemCount: lis.length,
                      itemBuilder: (context,int index){
                    return lis.elementAt(index);
                  }))))]));
            });
      },
    );
  }

  List<Widget> returnTagWidget(BuildContext context,Function popState, Function setMarkers, Function getMarkers) {
    List<Widget> wList = <Widget>[];
    // wList.add(Container(
    //   color: Colors.green,
    //   child: Text(
    //     "?????? #",
    //     style: TextStyle(color: Colors.white, fontSize: 20),
    //   ),
    //   alignment: Alignment.center,
    //   height: 63,
    // ));
    if(list.length==0){
      wList.add(ListTile(
          title:Text("????????????Tag",textAlign: TextAlign.center,)
      )
      );
    }
    list.forEach((element) {
      wList.add(ListTile(
        leading: Text(
          "#",
          style: TextStyle(fontSize: 20),
        ),
        title: Text(element, style: TextStyle(fontSize: 15)),
        trailing: CircleAvatar(
          child: TextButton(
            child: Text("-", style: TextStyle(fontSize: 20, color: Colors.white)),
            onPressed: () {
              fetchSpecies(element).then((query_result) async {
                Map<String, Marker> tmp = getMarkers();
                query_result.forEach((specie) {
                  tmp.remove(specie.marker_id.toString());
                  setMarkers(tmp);
                });
              });
              minusTag(list.indexWhere((element2) => element2==element),context,popState);
            },
          ),
          backgroundColor: Colors.black,
        ),
      ));
    });
    return wList;
  }
}
