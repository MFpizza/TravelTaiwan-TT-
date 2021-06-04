import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'AQIBar.dart';
import 'UVBar.dart';

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
                      getIcon(context, lis.elementAt(index)['weather']),
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
  Widget getIcon(context,String type){
    String iconName;

    if(type.contains('雨')||type.contains('雪'))
      iconName="rain";
    else if( type.contains('雲'))
      iconName='cloud';
    else iconName='sunny';

    return Container(width: MediaQuery.of(context).size.width * 0.35,height: MediaQuery.of(context).size.width * 0.35,decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/$iconName.png'),fit: BoxFit.cover)),);
  }
}
