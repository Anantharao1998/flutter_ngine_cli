import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juno_provider_base_project/config/config.dart';
import 'package:juno_provider_base_project/core/core.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

abstract class BaseView<T extends BaseProvider> extends StatelessWidget
    with SnackBarHelper {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final Logger logger = FlavorConfig.instance.logger;

  BaseView({super.key});

  Widget body(BuildContext context, T provider);

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ProviderViewBuilder<T>(
      onInit: (provider) => onInit(provider, context),
      builder: (ctx, provider) {
        return Stack(
          children: [
            annotatedRegion(context, provider),
            Selector<T, ViewState>(
              selector: (context, provider) => provider.viewState,
              builder: (context, state, _) =>
                  state == ViewState.loading ? _showLoading() : Container(),
            ),
            Selector<T, String>(
              selector: (context, provider) => provider.errorMessage,
              builder: (context, errorMessage, _) => errorMessage.isNotEmpty
                  ? showErrorSnackBar(errorMessage)
                  : Container(),
            ),
          ],
        );
      },
    );
  }

  Widget annotatedRegion(BuildContext context, T provider) {
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
        child: pageScaffold(context, provider),
      ),
    );
  }

  Widget pageScaffold(BuildContext context, T provider) {
    return Scaffold(
      //sets ios status bar color
      backgroundColor: pageBackgroundColor(),
      key: globalKey,
      appBar: appBar(context),
      floatingActionButton: floatingActionButton(),
      body: body(context, provider),
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

  T onInit(T provider, BuildContext context) {
    return provider;
  }

  // T onInit(T provider);

  // T onInit(T provider) => provider;
}
