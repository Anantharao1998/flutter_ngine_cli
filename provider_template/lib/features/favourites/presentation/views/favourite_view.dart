import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/core.dart';

class FavoriteView extends StatelessWidget with BaseViewWidgetMixin {
  FavoriteView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      appBarTitleText: 'Favorite',
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
