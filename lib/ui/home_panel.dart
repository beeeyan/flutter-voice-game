import 'package:flutter/material.dart';

class HomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: 150,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: RaisedButton(
            color: Colors.grey[300],
            child: const Text('早口言葉レベル1'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/play/basic");
            },
            highlightColor: Colors.redAccent,
            onHighlightChanged: (value) {},
          ),
        ),
        ButtonTheme(
          minWidth: 150,
          height: 200,
          padding: const EdgeInsets.all(20),
          child: RaisedButton(
            color: Colors.grey[300],
            child: const Text('早口言葉レベル2'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/play/advanced");
            },
            highlightColor: Colors.blueAccent,
            onHighlightChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
