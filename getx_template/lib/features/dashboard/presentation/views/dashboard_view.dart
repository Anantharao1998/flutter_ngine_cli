import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base_view.dart';
import 'package:juno_getx_base_project/features/dashboard/dashboard.dart';
import 'package:juno_getx_base_project/features/favourite/favourite.dart';
import 'package:juno_getx_base_project/features/home/home.dart';
import 'package:juno_getx_base_project/features/settings/settings.dart';

class DashboardView extends BaseView<DashboardController> {
  DashboardView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Obx(() => getPageOnSelectedMenu(controller.selectedMenuCode)),
    );
  }

  @override
  Widget? bottomNavigationBar() =>
      BottomNavBar(onNewMenuSelected: controller.onMenuSelected);

  Widget getPageOnSelectedMenu(MenuCode menuCode) {
    switch (menuCode) {
      case MenuCode.home:
        return HomeView();
      case MenuCode.favourite:
        return FavoriteView();
      case MenuCode.settings:
        return SettingsView();
      default:
        return Container();
    }
  }
}
