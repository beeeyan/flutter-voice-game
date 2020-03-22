import 'package:flutter/material.dart';
import 'page/home_page.dart';
import 'page/play_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String title = 'SPELL BOOK';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        // default
        // primarySwatch: Colors.cyan,
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.blueGrey[600],
      ),
      home: MyHomePage(title: title),
      routes: <String,WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage(title: title),
        '/play/basic': (BuildContext context) => PlayPage(title: title, level: 'basic'),
        '/play/advanced': (BuildContext context) => PlayPage(title: title, level: 'advanced'),
      },
    );
  }
}