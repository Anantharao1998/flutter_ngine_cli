import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base.dart';
import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:juno_getx_base_project/features/project_details/project_details.dart';

class ProjectDetailsView extends BaseView<ProjectDetailsController> {
  ProjectDetailsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      appBarTitleText: 'Repository details',
      isBackButtonEnabled: true,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => _getView()),
      ),
    );
  }

  Widget _getView() {
    return controller.projectUiData?.name?.isEmpty ?? false
        ? Container()
        : Container(
            margin: const EdgeInsets.all(AppValues.margin_20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.projectUiData?.name ?? '',
                  style: cardTitleStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                _getAuthor(),
                const SizedBox(height: AppValues.margin_4),
                _getForkStarWatcherView(),
                const SizedBox(height: AppValues.margin_30),
                _getDescription()
              ],
            ),
          );
  }

  Widget _getAuthor() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage:
              NetworkImage(controller.projectUiData?.owner?.avatarUrl ?? ''),
          radius: AppValues.iconSmallSize,
        ),
        const SizedBox(width: AppValues.margin_6),
        Text(
          controller.projectUiData?.owner?.login ?? '',
          style: cardSubtitleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _getForkStarWatcherView() {
    return Container(
      margin: const EdgeInsets.only(left: AppValues.margin_40),
      child: Row(
        children: [
          IconTextWidget(
            fileName: AppAssets.icFork,
            value: controller.projectUiData?.forks.toString() ?? '',
            height: AppValues.iconSize_20,
            width: AppValues.iconSize_20,
            color: AppColors.iconColorDefault,
          ),
          IconTextWidget(
            icon: Icons.star_border,
            value: controller.projectUiData?.stargazersCount.toString() ?? '',
            size: AppValues.iconSize_20,
            color: AppColors.iconColorDefault,
          ),
          IconTextWidget(
            icon: Icons.visibility_outlined,
            value: controller.projectUiData?.watchers.toString() ?? '',
            size: AppValues.iconSize_20,
            color: AppColors.iconColorDefault,
          ),
        ],
      ),
    );
  }

  Widget _getDescription() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(controller.projectUiData?.description ?? '',
            style: descriptionTextStyle),
      ),
    );
  }
}
