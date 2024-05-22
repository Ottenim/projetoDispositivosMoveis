import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? iconData;

  const BaseButton({
    super.key,
    required this.title,
    this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFFF112),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size.fromHeight(44),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xff363435),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
