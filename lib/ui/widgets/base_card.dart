import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({super.key, this.child, this.onTap});

  final Widget? child;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 64,
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: const Color(0xff262626),
          child: child,
        ),
      ),
    );
  }
}
