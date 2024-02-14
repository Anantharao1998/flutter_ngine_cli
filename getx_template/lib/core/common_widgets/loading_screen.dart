import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juno_getx_base_project/core/values/values.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    this.size = AppValues.margin_30,
    this.color = AppColors.teal400,
    Key? key,
  }) : super(key: key);

  final double size;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color,
      size: size,
    );
  }
}
