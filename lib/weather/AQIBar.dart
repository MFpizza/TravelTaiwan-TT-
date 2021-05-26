import 'package:flutter/material.dart';

class AQIBar extends StatelessWidget {

  final aqi_value;

  AQIBar({Key key, @required this.aqi_value}): super(key: key);

  @override
  Widget build(BuildContext context) {

    final barWidth = MediaQuery.of(context).size.width - 80;

    Color valueTextColor;
    var boxLeftMarginValue = 0.0;

    switch(aqi_value){
      case 0:
        boxLeftMarginValue = barWidth * 0;
        valueTextColor = Colors.lightGreen;
      break;
      case 1:
        boxLeftMarginValue = barWidth * 0.0714285714285714;
        valueTextColor = Colors.lightGreen;
      break;
      case 2:
        boxLeftMarginValue = barWidth * 0.1428571428571428;
        valueTextColor = Colors.lightGreen;
      break;
      case 3:
        boxLeftMarginValue = barWidth * 0.2142857142857142;
        valueTextColor = Colors.yellow;
      break;
      case 4:
        boxLeftMarginValue = barWidth * 0.2857142857142856;
        valueTextColor = Colors.yellow;
      break;
      case 5:
        boxLeftMarginValue = barWidth * 0.357142857142857;
        valueTextColor = Colors.orange;
      break;
      case 6:
        boxLeftMarginValue = barWidth * 0.4285714285714284;
        valueTextColor = Colors.orange;
      break;
      case 7:
        boxLeftMarginValue = barWidth * 0.4999999999999998;
        valueTextColor = Colors.red[800];
      break;
      case 8:
        boxLeftMarginValue = barWidth * 0.5714285714285712;
        valueTextColor = Colors.red[800];
      break;
      case 9:
        boxLeftMarginValue = barWidth * 0.6428571428571426;
        valueTextColor = Colors.purple;
      break;
      case 10:
        boxLeftMarginValue = barWidth * 0.714285714285714;
        valueTextColor = Colors.purple;
      break;
      case 11:
        boxLeftMarginValue = barWidth * 0.7857142857142854;
        valueTextColor = Colors.brown[800];
      break;
      case 12:
        boxLeftMarginValue = barWidth * 0.8571428571428568;
        valueTextColor = Colors.brown[800];
      break;
      case 13:
        boxLeftMarginValue = barWidth * 0.9285714285714282;
        valueTextColor = Colors.black;
      break;
      case 14:
        boxLeftMarginValue = barWidth;
        valueTextColor = Colors.black;
      break;
      default:
        boxLeftMarginValue = barWidth;
        valueTextColor = Colors.black;
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(40, 20, 0, 13),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("空氣品質", style: TextStyle(color: Colors.grey[700], fontSize: 33)),
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(21, 0, 0, 0),
            child: Container(
                margin: EdgeInsets.only(left: boxLeftMarginValue), // Here
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text("AQI", style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                        Container(
                            width: 38,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(aqi_value.toString(), style: TextStyle(color: valueTextColor, fontSize: 33, fontWeight: FontWeight.w500))
                            )
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                          height: 10,
                          child: CustomPaint(
                            painter: TriangleIndicatorPainter(triangleColor: valueTextColor),
                          ),
                        )
                      ],
                    )
                )
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.lightGreen,
                              Colors.yellow,
                              Colors.orange,
                              Colors.red[800],
                              Colors.purple,
                              Colors.brown[800],
                              Colors.black,
                            ],
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: boxLeftMarginValue), // Here
                  child: CustomPaint(
                    painter: WhileLineIndicatorPainter(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0", style: TextStyle(color: Colors.grey)),
                CustomPaint(
                  painter: ArrowPainter(barWidth: barWidth),
                ),
                Text("14", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 55, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomPaint(
                        painter: DotPainter(color: Colors.lightGreen),
                      )
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Text("0~2", style: TextStyle(color: Colors.lightGreen, fontSize: 20)),
                      )
                    ),
                    Expanded(
                      flex: 6,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("良好", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                        )
                      )
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomPaint(
                          painter: DotPainter(color: Colors.yellow),
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text("3~4", style: TextStyle(color: Colors.yellow, fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("普通", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                          )
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomPaint(
                          painter: DotPainter(color: Colors.orange),
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text("5~6", style: TextStyle(color: Colors.orange, fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("對敏感族群不健康", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                          )
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomPaint(
                          painter: DotPainter(color: Colors.red[800]),
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text("7~8", style: TextStyle(color: Colors.red[800], fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("對所有族群不健康", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                          )
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomPaint(
                          painter: DotPainter(color: Colors.purple),
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text("9~10", style: TextStyle(color: Colors.purple, fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("非常不健康", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                          )
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomPaint(
                          painter: DotPainter(color: Colors.brown[800]),
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text("11~12", style: TextStyle(color: Colors.brown[800], fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("危害", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                          )
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomPaint(
                          painter: DotPainter(color: Colors.black),
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Text("13~14", style: TextStyle(color: Colors.black, fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("危險", style: TextStyle(color: Colors.grey[700], fontSize: 20))
                          )
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
  }

}

class ArrowPainter extends CustomPainter {

  var barWidth;

  ArrowPainter({@required this.barWidth});

  @override
  void paint(Canvas canvas, Size size) {

    var halfArrowWidth = barWidth / 2 - 23;

    Path path;

    // The arrows usually looks better with rounded caps.
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2.0;

    path = Path();
    path.moveTo(-halfArrowWidth - 3, 0);
    path.lineTo(halfArrowWidth, 0);
    canvas.drawPath(path, paint);

    paint..style = PaintingStyle.fill;
    path.moveTo(halfArrowWidth, 0);
    path.lineTo(halfArrowWidth, -5);
    path.lineTo(halfArrowWidth + 8, 0);
    path.lineTo(halfArrowWidth, 5);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => true;
}

class DotPainter extends CustomPainter {

  Color color = Colors.black;
  DotPainter({@required this.color});

  @override
  void paint(Canvas canvas, Size size) {


    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(13, 0), 12, paint);
  }

  @override
  bool shouldRepaint(DotPainter oldDelegate) => true;
}

class WhileLineIndicatorPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Path path;

    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 4.0;

    path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, 30);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WhileLineIndicatorPainter oldDelegate) => true;
}

class TriangleIndicatorPainter extends CustomPainter {

  Color triangleColor;

  TriangleIndicatorPainter({@required this.triangleColor});

  @override
  void paint(Canvas canvas, Size size) {
    Path path;

    Paint paint = Paint()
      ..color = triangleColor
      ..style = PaintingStyle.fill;

    path = Path();
    path.moveTo(-8, -8);
    path.lineTo(8, -8);
    path.lineTo(0, 4);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TriangleIndicatorPainter oldDelegate) => true;
}

