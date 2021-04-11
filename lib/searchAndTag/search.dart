import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tag.dart';

class SearchPage extends StatefulWidget {
  final Tag tag;

  SearchPage({Key key, this.tag}) : super(key: key);

  _SearchPage createState() => _SearchPage(tag: tag);
}

class _SearchPage extends State<SearchPage> {
  final Tag tag;

  _SearchPage({this.tag});
//  final FocusNode _focus = FocusNode();
  final TextEditingController _chatController = TextEditingController();
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
                      TextField(
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
                        controller: _chatController,
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
                                tag.showPopWindows(context);
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
