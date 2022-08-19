import 'game.dart';
import 'package:flutter/material.dart';

class Chess extends StatelessWidget {
  const Chess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game();
    );
  }
}
