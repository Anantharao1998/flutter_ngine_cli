import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/values/values.dart';

mixin SnackBarHelper {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  void showLoadingSnackBar() {
    snackbarKey.currentState
        ?.showSnackBar(
          const SnackBar(
            content: Center(
              child: LoadingScreen(),
            ),
            backgroundColor: Colors.transparent,
            duration: Duration(days: 1),
          ),
        )
        .closed
        .then((reason) {
      if (reason == SnackBarClosedReason.swipe) showLoadingSnackBar();
    });
  }

  void removeSnackBar(BuildContext context) {
    snackbarKey.currentState?.removeCurrentSnackBar();
  }

  Widget showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((__) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });

    return Container();
  }

  void removeErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  void showSuccessSnackBar(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SUCCESS'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 10),
      ),
    );
  }

  void showWarningSnackBar(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? ''),
        backgroundColor: Colors.orange,
        duration: const Duration(
          seconds: 18,
        ),
      ),
    );
  }

  void showNoInternetSnackBar({String? message}) {
    ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        margin: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message ?? AppStrings.noInternetConnection.tr,
          style: greyDarkTextStyle.copyWith(
              fontWeight: FontWeight.w600, color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.red400,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void removeShowNoInternetSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
