import 'package:flutter/material.dart';

class HomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _panels;
  }

  final Widget _panels = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey[300],
        width: 180,
        height: 200,
        child: Center(
          child: const Text('早口言葉レベル1'),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey[300],
        width: 180,
        height: 200,
        child: Center(
          child: const Text('早口言葉レベル2'),
        ),
      ),
    ],
  );
}
