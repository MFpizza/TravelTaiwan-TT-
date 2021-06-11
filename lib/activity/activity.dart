import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class Activity extends StatefulWidget {
  @override
  _Activity createState() => _Activity();
}

class _Activity extends State<Activity> {
  File _image;
  final picker = ImagePicker();
  Response response;
  var dio = Dio();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    print(pickedFile);
    if(pickedFile==null)
      return;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    try {
      FormData formData = new FormData.fromMap({
        "img": await MultipartFile.fromFile(pickedFile.path,
            filename: 'upload.jpg')
      });
      print(formData);
      EasyLoading.show(status: 'loading...');
      response =
          await dio.post("https://netlab.ar3s.dev/travel_taiwan/ai/", data: formData);
      print(response.data['msg']);
      EasyLoading.dismiss();
      if(response.data['msg']==true){
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text(
                  "恭喜，你找到了!",
                  style: TextStyle(fontSize: 20),
                ),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text("確定"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
      else{
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text(
                  "系統檢測這不是捏QQ",
                  style: TextStyle(fontSize: 20),
                ),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text("確定"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: Text(
                "有地方出錯了，請回報給\ns1071443@g.yzu.edu.tw",
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                CupertinoButton(
                  child: Text("確定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('活動'),
        backgroundColor: Colors.green,
      ),
      body:
      Column(children: [
        Container(width: MediaQuery.of(context).size.width,height: 100,alignment: Alignment.center,child: Text('這季活動是: 百合花',style: TextStyle(fontSize: 24),),),
        Expanded(child: _image == null ? Text('還沒上傳圖片',style: TextStyle(fontSize: 16),) : Image.file(_image),)
      ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
