import 'package:flutter/material.dart';

class HomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: 180,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: RaisedButton(
            color: Colors.grey[300],
            child: const Text('早口言葉レベル1'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/play");
            },
            highlightColor: Colors.redAccent,
            onHighlightChanged: (value) {},
          ),
        ),
        ButtonTheme(
          minWidth: 180,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: RaisedButton(
            color: Colors.grey[300],
            child: const Text('早口言葉レベル2'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/play");
            },
            highlightColor: Colors.blueAccent,
            onHighlightChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
