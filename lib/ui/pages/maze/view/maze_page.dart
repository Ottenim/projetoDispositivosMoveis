import 'package:barber/ui/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maze/maze.dart';

class MazePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => MazePage());

  const MazePage({super.key});

  @override
  State<MazePage> createState() => _MazePageState();
}

class _MazePageState extends State<MazePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(title: 'Maze'),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Maze(
          player: MazeItem('https://cdn-icons-png.flaticon.com/512/1950/1950591.png', ImageType.network),
          columns: 6,
          rows: 12,
          wallThickness: 4.0,
          wallColor: Theme.of(context).primaryColor,
          finish: MazeItem('https://cdn-icons-png.flaticon.com/512/4744/4744812.png', ImageType.network),
          onFinish: () async {
            Fluttertoast.showToast(msg: 'Parabéns você chegou ao final!!');

            await Future.delayed(Duration(seconds: 1));

            Navigator.of(context).pop();
          },
        )));
  }
}
