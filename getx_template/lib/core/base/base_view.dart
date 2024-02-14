import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/config/config.dart';
import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/enum/enum.dart';
import 'package:juno_getx_base_project/core/utils/snack_bar_helper.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:logger/logger.dart';

import 'base_controller.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> with SnackBarHelper {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final Logger logger = FlavorConfig.instance.logger;

  BaseView({super.key});

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          annotatedRegion(context),
          Obx(() => controller.viewState == ViewState.loading
              ? _showLoading()
              : Container()),
          Obx(() => controller.errorMessage.isNotEmpty
              ? showErrorSnackBar(controller.errorMessage)
              : Container()),
          Container(),
        ],
      ),
    );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          //Status bar color for android
          statusBarColor: AppColors.appBarColor,
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

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
  }

  Color pageBackgroundColor() => AppColors.pageBackground;

  Color statusBarColor() => AppColors.pageBackground;

  Widget? floatingActionButton() => null;

  Widget? bottomNavigationBar() => null;

  Widget? drawer() => null;

  Widget _showLoading() => const Center(child: Loading());
}
