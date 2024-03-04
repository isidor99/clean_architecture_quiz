import 'package:flutter/material.dart';

class ThemeItem extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const ThemeItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(title),
    );
  }
}
