import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(
              'メニュー',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            // home画面
            leading: Icon(Icons.home),
            title: Text('ホーム'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/home");
            },
          ),
          //ListTile(
          // 設定画面
          // leading: Icon(Icons.settings),
          // title: Text('設定'),
          //),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('閉じる'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
