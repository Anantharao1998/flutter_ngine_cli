import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/base/base_provider_widget.dart';
import 'package:juno_provider_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_provider_base_project/core/values/values.dart';
import 'package:juno_provider_base_project/features/dashboard/domain/entities/menu_code.dart';
import 'package:juno_provider_base_project/features/dashboard/domain/entities/menu_item.dart';
import 'package:juno_provider_base_project/features/dashboard/presentation/provider/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends BaseProviderWidget<BottomNavProvider> {
  BottomNavBar({
    Key? key,
  }) : super(key: key);

  final Key bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context, BottomNavProvider provider) {
    const Color selectedItemColor = AppColors.white;
    const Color unselectedItemColor = AppColors.grey;
    final List<BottomNavItem> navItems = _getNavItems();

    return Selector<BottomNavProvider, int>(
      selector: (_, provider) => provider.selectedIndex,
      builder: (context, selectedIndex, child) => BottomNavigationBar(
        key: bottomNavKey,
        items: navItems
            .map(
              (BottomNavItem navItem) => BottomNavigationBarItem(
                  icon: AssetImageView(
                    fileName: navItem.iconSvgName,
                    height: AppValues.iconDefaultSize,
                    width: AppValues.iconDefaultSize,
                    color: navItems.indexOf(navItem) == selectedIndex
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
        currentIndex: selectedIndex,
        onTap: (index) => provider.updateSelectedIndex(index),
      ),
    );
  }

  List<BottomNavItem> _getNavItems() {
    return [
      const BottomNavItem(
        navTitle: 'Home',
        iconSvgName: AppAssets.icHome,
        menuCode: MenuCode.home,
      ),
      const BottomNavItem(
          navTitle: 'Favorite',
          iconSvgName: AppAssets.icFavorite,
          menuCode: MenuCode.favourite),
      const BottomNavItem(
          navTitle: 'Settings',
          iconSvgName: AppAssets.icSettings,
          menuCode: MenuCode.settings)
    ];
  }
}
