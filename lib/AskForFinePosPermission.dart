import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'HomePage.dart';

class AskForFinePosPermission extends StatefulWidget {
  AskForFinePosPermission({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AskForFinePosPermissionState createState() => _AskForFinePosPermissionState();
}

class _AskForFinePosPermissionState extends State<AskForFinePosPermission> {

  @override
  void initState(){
    super.initState();
    _checkFinePosPermission();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:
        null
    );
  }

  void _checkFinePosPermission() async {
    if (await Permission.location.request().isGranted) {
      log('Location Permission Granted!');
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage())
      );
    }
    else {
      Fluttertoast.showToast(
        msg: "此應用程式需要位置權限，請手動至設定允許",
        toastLength: Toast.LENGTH_LONG,
      );
      SystemNavigator.pop();
    }
  }
}