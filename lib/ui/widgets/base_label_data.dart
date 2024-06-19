import 'package:flutter/material.dart';

class BaseLabelData extends StatelessWidget {
  const BaseLabelData({
    super.key,
    this.padding,
    this.label,
    this.data,
  });

  final EdgeInsetsGeometry? padding;
  final String? label;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text.rich(
        maxLines: 1,
        TextSpan(
          children: [
            TextSpan(
              style: TextStyle(fontSize: 12.8, fontWeight: FontWeight.w500),
              text: '$label: ',
            ),
            TextSpan(
              style: TextStyle(fontSize: 12.8),
              text: data,
            ),
          ],
        ),
      ),
    );
  }
}
