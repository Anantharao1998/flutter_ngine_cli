import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/base/base_widget_mixin.dart';

import 'package:juno_provider_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_provider_base_project/core/values/values.dart';

class ItemSettings extends StatelessWidget with BaseWidgetMixin {
  final String prefixImage;
  final String suffixImage;
  final String title;
  final Function()? onTap;

  ItemSettings(
      {required this.prefixImage,
      required this.suffixImage,
      required this.title,
      required this.onTap,
      super.key});

  @override
  Widget body(BuildContext context) {
    return Ripple(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Row(
          children: [
            AssetImageView(
              fileName: prefixImage,
              height: AppValues.iconSize_20,
              width: AppValues.iconSize_20,
            ),
            const SizedBox(width: AppValues.smallPadding),
            Text(title, style: settingsItemStyle),
            const Spacer(),
            AssetImageView(
              fileName: suffixImage,
              color: AppColors.suffixImageColor,
              height: AppValues.iconSize_20,
              width: AppValues.iconSize_20,
            ),
          ],
        ),
      ),
    );
  }
}
