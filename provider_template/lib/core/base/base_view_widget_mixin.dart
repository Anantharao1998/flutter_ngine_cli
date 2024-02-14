import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juno_provider_base_project/config/config.dart';
import 'package:juno_provider_base_project/core/core.dart';
import 'package:logger/logger.dart';

mixin BaseViewWidgetMixin on StatelessWidget {
  final Logger logger = FlavorConfig.instance.logger;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return annotatedRegion(context);
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          //Status bar color for android
          statusBarColor: statusBarColor(),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor:
              Platform.isAndroid ? AppColors.appBarColor : null,
          systemNavigationBarIconBrightness: Brightness.light),
      child: Material(
        color: Colors.transparent,
        child: pageScaffold(context),
      ),
    );
  }

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context) => null;

  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      //sets ios status bar color
      backgroundColor: pageBackgroundColor(),
      key: globalKey,
      appBar: appBar(context),
      floatingActionButton: floatingActionButton(),
      body: body(context),
      bottomNavigationBar: bottomNavigationBar(),
      drawer: drawer(),
    );
  }

  Color pageBackgroundColor() => AppColors.pageBackground;

  Color statusBarColor() => AppColors.appBarColor;

  Widget? floatingActionButton() => null;

  Widget? bottomNavigationBar() => null;

  Widget? drawer() => null;

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
  }
}
