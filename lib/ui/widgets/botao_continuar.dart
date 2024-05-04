import 'package:flutter/material.dart';

class BotaoContinuar extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const BotaoContinuar({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: const Color(0xFFFFF112),
        ),
        onPressed: onClicked,
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
