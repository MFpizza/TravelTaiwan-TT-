import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../member/member.dart';
import 'detail.dart';


Widget createContainer(String a,Function changeState,BuildContext context) {
  myMap.putIfAbsent(a, () => false);
  return Container(
    width: 170,
    height: 170,
    child: Column(
      children: [
        Stack(children: [
          InkWell(child:Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/material/$a.jpg'),
                    fit: BoxFit.cover)),
          ),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Detail(name: a,))),),
          Container(
            padding: EdgeInsets.all(5),
            width: 130,
            height: 130,
            alignment: Alignment.bottomRight,
            child: Container(
              //  color: Colors.orangeAccent,
              width: 40,
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.white,
                  ),
                  myMap[a]
                      ? IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                      size: IconThemeData.fallback().size - 5,
                    ),
                    onPressed: () {
                      myMap[a] = !myMap[a];
                      changeState();
                    },
                  )
                      : IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.grey,
                      size: IconThemeData.fallback().size - 5,
                    ),
                    onPressed: () {
                      myMap[a] = !myMap[a];
                      changeState();
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
        Divider(),
        Text(a)
      ],
    ),
  );
}