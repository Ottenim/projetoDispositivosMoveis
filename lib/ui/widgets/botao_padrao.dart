import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  String titulo;
  Function? onClick;
  IconData iconData;

  BotaoPadrao({
    super.key,
    required this.titulo,
    required this.onClick,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AbsorbPointer(
        child: MaterialButton(
          color: const Color(0xFF262626),
          height: 46,
          elevation: 4,
          animationDuration: const Duration(milliseconds: 200),
          mouseCursor: SystemMouseCursors.click,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () async {
            await onClick?.call();

            await Future.delayed(const Duration(milliseconds: 100));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFFFF112),
                ),
                alignment: Alignment.center,
                child: Icon(
                  iconData,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                titulo,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
