import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Navigator.of(context).canPop()
          ? GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_new, size: 24),
            )
          : Container(),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 62);
}
