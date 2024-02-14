import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:juno_getx_base_project/features/dashboard/dashboard.dart';

class BottomNavBar extends GetView<BottomNavController> {
  final Function(MenuCode menuCode) onNewMenuSelected;

  BottomNavBar({
    required this.onNewMenuSelected,
    Key? key,
  }) : super(key: key);

  final Key bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const Color selectedItemColor = AppColors.white;
    const Color unselectedItemColor = AppColors.grey;
    final List<BottomNavItem> navItems = _getNavItems();

    return Obx(
      () => BottomNavigationBar(
        key: bottomNavKey,
        items: navItems
            .map(
              (BottomNavItem navItem) => BottomNavigationBarItem(
                  icon: AssetImageView(
                    fileName: navItem.iconSvgName,
                    height: AppValues.iconDefaultSize,
                    width: AppValues.iconDefaultSize,
                    color: navItems.indexOf(navItem) == controller.selectedIndex
                        ? selectedItemColor
                        : unselectedItemColor,
                  ),
                  label: navItem.navTitle),
            )
            .toList(),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.colorAccent,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        currentIndex: controller.selectedIndex,
        onTap: (index) {
          controller.updateSelectedIndex(index);
          onNewMenuSelected(navItems[index].menuCode);
        },
      ),
    );
  }

  List<BottomNavItem> _getNavItems() {
    return [
      BottomNavItem(
        navTitle: AppStrings.bottomNavHome.tr,
        iconSvgName: AppAssets.icHome,
        menuCode: MenuCode.home,
      ),
      BottomNavItem(
          navTitle: AppStrings.bottomNavFavorite.tr,
          iconSvgName: AppAssets.icFavorite,
          menuCode: MenuCode.favourite),
      BottomNavItem(
          navTitle: AppStrings.bottomNavSettings.tr,
          iconSvgName: AppAssets.icSettings,
          menuCode: MenuCode.settings)
    ];
  }
}
