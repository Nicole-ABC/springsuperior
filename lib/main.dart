import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF070707),
        accentColor: Color(0xFFFFAAFF)
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
