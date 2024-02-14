import 'package:flutter/material.dart';
import 'package:juno_getx_base_project/core/values/values.dart';

class AppBarTitle extends StatelessWidget {
  final String text;

  const AppBarTitle({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: pageTitleStyle,
      textAlign: TextAlign.center,
    );
  }
}
