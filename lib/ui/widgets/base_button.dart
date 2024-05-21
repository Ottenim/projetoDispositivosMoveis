import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData iconData;

  const BaseButton({
    super.key,
    required this.title,
    required this.iconData,
    this.onPressed,
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
          onPressed: onPressed,
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
                title,
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
