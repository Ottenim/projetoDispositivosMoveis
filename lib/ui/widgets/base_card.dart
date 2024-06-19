import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    this.child,
    this.onTap,
    this.padding,
  });

  final Widget? child;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      child: Card(
        margin: EdgeInsets.zero,
        color: const Color(0xff262626),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(padding: const EdgeInsets.symmetric(vertical: 8), child: Center(child: child)),
        ),
      ),
    );
  }
}
