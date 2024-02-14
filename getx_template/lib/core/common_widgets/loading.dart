import 'package:flutter/material.dart';

import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/values/values.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: SizedBox(
            width: AppValues.loading,
            height: AppValues.loading,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 6,
                  color: AppColors.colorPrimary,
                  // backgroundColor: Colors.black,
                  // color: Colors.green,
                ),
                Center(
                  child: AssetImageView(
                    fileName: AppAssets.launcherIcon,
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
