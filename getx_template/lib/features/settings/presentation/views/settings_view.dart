import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base.dart';
import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:juno_getx_base_project/features/settings/settings.dart';

class SettingsView extends BaseView<SettingsController> {
  SettingsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
        appBarTitleText: AppStrings.bottomNavSettings.tr,
        isBackButtonEnabled: false);
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        ItemSettings(
          title: AppStrings.settingsTheme.tr,
          prefixImage: AppAssets.icTheme,
          suffixImage: AppAssets.arrowForward,
          onTap: _onThemeItemClicked,
        ),
        _getHorizontalDivider(),
        ItemSettings(
          title: AppStrings.settingsLanguage.tr,
          prefixImage: AppAssets.icLanguage,
          suffixImage: AppAssets.arrowForward,
          onTap: _onLanguageItemClicked,
        ),
        _getHorizontalDivider(),
        ItemSettings(
          title: AppStrings.settingsFontSize.tr,
          prefixImage: AppAssets.icFontSize,
          suffixImage: AppAssets.arrowForward,
          onTap: _onFontSizeItemClicked,
        ),
        _getHorizontalDivider(),
      ],
    );
  }

  Widget _getHorizontalDivider() {
    return const Divider(height: 1);
  }

  void _onThemeItemClicked() {
    showToast('Theme: Development in progress');
  }

  void _onLanguageItemClicked() {
    showToast('Language: Development in progress');
  }

  void _onFontSizeItemClicked() {
    showToast('Font Size: Development in progress');
  }
}
