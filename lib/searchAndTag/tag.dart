import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class Tag {
  List<String> list = ['flower','adad','ff'];
  void minusTag(int index,BuildContext context,Function popState) {
    popState((){list.removeAt(index);});
  }

  List<String> addTag(String value) {
    return list;
  }

  int size() {
    return list.length;
  }

  void showPopWindows(BuildContext context) {
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
                  //padding: EdgeInsets.all(10),
                  height: list.length!=0?(list.length + 1) * //TODO 123
                      65.toDouble():2*65.toDouble(),
                  width: 200,
//                                            color: Colors.black54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: this.returnTagWidget(context,popState),
                  ));
            });
      },
    );
  }

  List<Widget> returnTagWidget(BuildContext context,Function popState) {
    List<Widget> wList = <Widget>[];
    wList.add(Container(
      color: Colors.green,
      child: Text(
        "已選 #",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      alignment: Alignment.center,
      height: 63,
    ));
    if(list.length==0){
      wList.add(ListTile(
        title:Text("尚未選取Tag",textAlign: TextAlign.center,)
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
            onPressed: () => minusTag(list.indexWhere((element2) => element2==element),context,popState),
          ),
          backgroundColor: Colors.black,
        ),
      ));
    });
    return wList;
  }
}
