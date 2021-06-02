import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart';
import 'AQIBar.dart';
import 'UVBar.dart';
import 'dart:convert';

// ignore: must_be_immutable
class Weather extends StatelessWidget {
  final List lis;
  Weather({@required this.lis}) ;

  @override
  Widget build(BuildContext context) {
    return lis!=null?Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.5,
            child: Swiper(
              viewportFraction: 0.4,
              scale: 0.7,
              itemCount: lis.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Container(width: MediaQuery.of(context).size.width * 0.35,height: MediaQuery.of(context).size.width * 0.35,decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/sunny.png'),fit: BoxFit.cover)),),
                      Text("${lis.elementAt(index)['temp']}°C"),
                      Text("${lis.elementAt(index)['weekday']} ${lis.elementAt(index)['time']}")
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  // width: 50,height: 50,color: Colors.red,
                );
              },
            )),
        UVBar(
            uv_value:
            int.parse(lis.elementAt(0)['radius_idx'])),
        AQIBar(aqi_value: 5),
        SizedBox(height: 20)
      ],
    ):Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,child: Center(child: CircularProgressIndicator(),),);
  }

}
