import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart';
import 'dart:math';

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
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                getTongueTwister(),
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Image.asset('images/kaiju.png'),
            ),
          ),
        ],
      ),
    );
  }
}


String getTongueTwister(){
  // TODO DBから取得するように変更(記載場所ここではない気がしている)
  const List<String> themeList = ['生麦生米生卵', '隣の客はよく柿食う客だ', 'バスガス爆発','裏庭には二羽にわとりがいる','赤パジャマ黄パジャマ青パジャマ'];
  int index = Random().nextInt(themeList.length - 1);
  return themeList[index];
}
