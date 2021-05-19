import 'package:flutter/material.dart';
import 'AskForFinePosPermission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AskForFinePosPermission(),
      debugShowCheckedModeBanner: false,
    );
  }
}