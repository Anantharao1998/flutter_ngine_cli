import 'package:flutter/material.dart';

import 'package:juno_provider_base_project/core/base/base_view_widget_mixin.dart';
import 'package:juno_provider_base_project/core/common_widgets/provider_builder.dart';
import 'package:juno_provider_base_project/features/dashboard/domain/entities/menu_code.dart';
import 'package:juno_provider_base_project/features/dashboard/presentation/provider/bottom_nav_provider.dart';
import 'package:juno_provider_base_project/features/dashboard/presentation/widgets/bottom_nav_bar.dart';
import 'package:juno_provider_base_project/features/favourites/favourites.dart';
import 'package:juno_provider_base_project/features/home/home.dart';
import 'package:juno_provider_base_project/features/settings/settings.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget with BaseViewWidgetMixin {
  DashboardView({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Selector<BottomNavProvider, int>(
        selector: (_, provider) => provider.selectedIndex,
        builder: (__, selectedIndex, child) => IndexedStack(
          index: selectedIndex,
          children: [
            ...bottomSheetScreens.map((e) => e).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget pageScaffold(BuildContext context) {
    return ProviderViewBuilder<BottomNavProvider>(
      builder: (context, provider) => Scaffold(
        backgroundColor: pageBackgroundColor(),
        key: globalKey,
        appBar: appBar(context),
        body: body(context),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  @override
  Widget? bottomNavigationBar() => BottomNavBar();

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

  final List<Widget> bottomSheetScreens = [
    HomeView(),
    FavoriteView(),
    SettingsView(),
  ];
}
