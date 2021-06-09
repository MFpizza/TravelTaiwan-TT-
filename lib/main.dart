import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'AskForFinePosPermission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Taiwan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AskForFinePosPermission(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}