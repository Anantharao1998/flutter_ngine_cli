import 'package:flutter/material.dart';
import 'package:juno_getx_base_project/config/config.dart';
import 'package:logger/logger.dart';

mixin BaseWidgetMixin on StatelessWidget {
  final Logger logger = FlavorConfig.instance.logger;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }

  Widget body(BuildContext context);
}
