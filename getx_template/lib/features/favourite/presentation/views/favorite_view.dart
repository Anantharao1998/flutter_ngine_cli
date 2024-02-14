import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base.dart';
import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:juno_getx_base_project/features/favourite/favourite.dart';

class FavoriteView extends BaseView<FavoriteController> {
  FavoriteView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: AppStrings.bottomNavFavorite.tr,
    );
  }

  @override
  Widget body(BuildContext context) {
    return const Center(
      child: Text(
        'FavoriteView is working',
        style: titleStyle,
      ),
    );
  }
}
