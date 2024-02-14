import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/values/values.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const ElevatedContainer(
      {required this.child,
      this.bgColor = AppColors.pageBackground,
      this.padding,
      this.borderRadius = AppValues.smallRadius,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.elevatedContainerColorOpacity,
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: AppColors.pageBackground),
      child: child,
    );
  }
}
