import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/core.dart';

mixin SnackBarHelper {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  void removeSnackBar(BuildContext context) {
    snackbarKey.currentState?.removeCurrentSnackBar();
  }

  Widget showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((__) {
      ScaffoldMessenger.of(navigationService.navigationKey.currentContext!)
          .showSnackBar(snackBar);
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
    ScaffoldMessenger.of(navigationService.navigationKey.currentContext!)
        .removeCurrentSnackBar();
    ScaffoldMessenger.of(navigationService.navigationKey.currentContext!)
        .showSnackBar(
      SnackBar(
        margin: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message ?? AppStrings.noInternetConnection,
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
