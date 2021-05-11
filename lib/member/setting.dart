import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("帳號設定"),
          ),ListTile(
            title: Text("製作團隊"),
          ),ListTile(
            title: Text("資料來源"),
          ),ListTile(
            title: Text("登出"),
          )
        ],
      ),
    );
  }
}
