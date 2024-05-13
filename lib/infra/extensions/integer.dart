import 'package:flutter/cupertino.dart';

extension OnInt on int {
  Widget toSizedBoxH() => SizedBox(height: toDouble());

  Widget toSizedBoxW() => SizedBox(width: toDouble());
}
