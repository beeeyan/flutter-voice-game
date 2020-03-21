import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key, this.title}) : super(key: key);

  final String title;

  // アロー関数を用いて、Stateを呼ぶ
  @override
  State<StatefulWidget> createState() =>  _PlayPage();
}

class _PlayPage extends State<PlayPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
