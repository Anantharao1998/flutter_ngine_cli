import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/core.dart';
import 'package:juno_provider_base_project/features/settings/presentation/widgets/item_settings_widgets.dart';

class SettingsView extends StatelessWidget with BaseViewWidgetMixin {
  SettingsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
        appBarTitleText: 'Settings', isBackButtonEnabled: false);
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        ItemSettings(
          title: AppStrings.settingsTheme,
          prefixImage: AppAssets.icTheme,
          suffixImage: AppAssets.arrowForward,
          onTap: _onThemeItemClicked,
        ),
        _getHorizontalDivider(),
        ItemSettings(
          title: AppStrings.settingsLanguage,
          prefixImage: AppAssets.icLanguage,
          suffixImage: AppAssets.arrowForward,
          onTap: _onLanguageItemClicked,
        ),
        _getHorizontalDivider(),
        ItemSettings(
          title: AppStrings.settingsFontSize,
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
