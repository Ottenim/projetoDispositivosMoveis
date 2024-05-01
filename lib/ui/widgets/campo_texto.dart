import 'package:flutter/cupertino.dart';

class CampoTexto extends StatelessWidget {
  IconData? icon;
  String? hint;

  CampoTexto({this.icon, this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
        child: Container(
          width: 340,
          height: 50,
          decoration: ShapeDecoration(
            color: const Color(0xFF262626),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 14),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 20,
                  height: 20,
                  child: icon == null ? SizedBox() : Icon(icon),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    textAlign: TextAlign.start,
                    hint ?? '',
                    style: const TextStyle(
                        color: Color(0xFF8E8E8E),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.8),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
