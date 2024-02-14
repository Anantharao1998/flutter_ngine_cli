import 'package:flutter/material.dart';
import '../values/app_colors.dart';
import '../values/app_values.dart';

class Ripple extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final Color rippleColor;
  final double rippleRadius;

  const Ripple({
    required this.onTap,
    Key? key,
    this.child,
    this.rippleColor = AppColors.defaultRippleColor,
    this.rippleRadius = AppValues.smallRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(rippleRadius),
        highlightColor: rippleColor,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
