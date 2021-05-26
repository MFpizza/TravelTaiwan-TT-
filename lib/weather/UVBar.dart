import 'package:flutter/material.dart';

class UVBar extends StatelessWidget {

  final uv_value;

  UVBar({Key key, @required this.uv_value}): super(key: key);

  @override
  Widget build(BuildContext context) {

    final barWidth = MediaQuery.of(context).size.width - 80;

    Color valueTextColor;
    var boxLeftMarginValue = 0.0;

    switch(uv_value){
      case 0:
        boxLeftMarginValue = barWidth * 0;
        valueTextColor = Colors.lightGreen;
      break;
      case 1:
        boxLeftMarginValue = barWidth * 0.0833333333333333;
        valueTextColor = Colors.lightGreen;
      break;
      case 2:
        boxLeftMarginValue = barWidth * 0.1666666666666667;
        valueTextColor = Colors.lightGreen;
      break;
      case 3:
        boxLeftMarginValue = barWidth * 0.25;
        valueTextColor = Colors.yellow;
      break;
      case 4:
        boxLeftMarginValue = barWidth * 0.3333333333333333;
        valueTextColor = Colors.yellow;
      break;
      case 5:
        boxLeftMarginValue = barWidth * 0.4166666666666667;
        valueTextColor = Colors.yellow;
      break;
      case 6:
        boxLeftMarginValue = barWidth * 0.5;
        valueTextColor = Colors.orange;
      break;
      case 7:
        boxLeftMarginValue = barWidth * 0.5833333333333333;
        valueTextColor = Colors.orange;
      break;
      case 8:
        boxLeftMarginValue = barWidth * 0.6666666666666667;
        valueTextColor = Colors.red[800];
      break;
      case 9:
        boxLeftMarginValue = barWidth * 0.75;
        valueTextColor = Colors.red[800];
      break;
      case 10:
        boxLeftMarginValue = barWidth * 0.8333333333333333;
        valueTextColor = Colors.red[800];
      break;
      case 11:
        boxLeftMarginValue = barWidth * 0.9166666666666667;
        valueTextColor = Colors.purple;
      break;
      default:
        boxLeftMarginValue = barWidth;
        valueTextColor = Colors.purple;
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(40, 20, 0, 13),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("紫外線", style: TextStyle(color: Colors.grey[700], fontSize: 33)),
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
                        Text("指數", style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                        Container(
                          width: 38,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(uv_value.toString(), style: TextStyle(color: valueTextColor, fontSize: 33, fontWeight: FontWeight.w500)),
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
                Text("11+", style: TextStyle(color: Colors.grey))
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
                          child: Text("低量級", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),Row(
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
                          child: Text("3~5", style: TextStyle(color: Colors.yellow, fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("中量級", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),Row(
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
                          child: Text("6~7", style: TextStyle(color: Colors.orange, fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("高量級", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),Row(
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
                          child: Text("8~10", style: TextStyle(color: Colors.red[800], fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("過量級", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                        )
                    )
                  ],
                ),
                SizedBox(height: 20),Row(
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
                          child: Text("11+", style: TextStyle(color: Colors.purple, fontSize: 20)),
                        )
                    ),
                    Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("危險級", style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                        )
                    )
                  ],
                ),
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
    path.moveTo(-halfArrowWidth, 0);
    path.lineTo(halfArrowWidth, 0);
    canvas.drawPath(path, paint);

    paint..style = PaintingStyle.fill;
    path.moveTo(halfArrowWidth - 3, 0);
    path.lineTo(halfArrowWidth - 3, -5);
    path.lineTo(halfArrowWidth + 5, 0);
    path.lineTo(halfArrowWidth - 3, 5);
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

