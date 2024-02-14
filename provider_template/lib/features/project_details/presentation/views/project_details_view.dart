import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/arguments/arguments.dart';
import 'package:juno_provider_base_project/core/base/base.dart';
import 'package:juno_provider_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_provider_base_project/core/values/values.dart';
import 'package:juno_provider_base_project/features/project_details/presentation/provider/project_detail_provider.dart';
import 'package:provider/provider.dart';

class ProjectDetailsView extends BaseView<ProjectDetailsProvider> {
  ProjectDetailsView({required this.argument, super.key});

  final ProjectDetailsArgument argument;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      appBarTitleText: 'Repository details',
      isBackButtonEnabled: true,
    );
  }

  @override
  Widget body(BuildContext context, ProjectDetailsProvider provider) {
    return Scaffold(
      body: Center(
        child: Consumer<ProjectDetailsProvider>(
          builder: (context, provider, child) => _getView(provider),
        ),
      ),
    );
  }

  @override
  ProjectDetailsProvider onInit(
      ProjectDetailsProvider provider, BuildContext context) {
    provider.onInit(argument);

    return super.onInit(provider, context);
  }

  Widget _getView(ProjectDetailsProvider provider) {
    return provider.projectUiData?.name?.isEmpty ?? false
        ? Container()
        : Container(
            margin: const EdgeInsets.all(AppValues.margin_20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.projectUiData?.name ?? '',
                  style: cardTitleStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                _getAuthor(provider),
                const SizedBox(height: AppValues.margin_4),
                _getForkStarWatcherView(provider),
                const SizedBox(height: AppValues.margin_30),
                _getDescription(provider)
              ],
            ),
          );
  }

  Widget _getAuthor(ProjectDetailsProvider provider) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage:
              NetworkImage(provider.projectUiData?.owner?.avatarUrl ?? ''),
          radius: AppValues.iconSmallSize,
        ),
        const SizedBox(width: AppValues.margin_6),
        Text(
          provider.projectUiData?.owner?.login ?? '',
          style: cardSubtitleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _getForkStarWatcherView(ProjectDetailsProvider provider) {
    return Container(
      margin: const EdgeInsets.only(left: AppValues.margin_40),
      child: Row(
        children: [
          IconTextWidget(
            fileName: AppAssets.icFork,
            value: provider.projectUiData?.forks.toString() ?? '',
            height: AppValues.iconSize_20,
            width: AppValues.iconSize_20,
            color: AppColors.iconColorDefault,
          ),
          IconTextWidget(
            icon: Icons.star_border,
            value: provider.projectUiData?.stargazersCount.toString() ?? '',
            size: AppValues.iconSize_20,
            color: AppColors.iconColorDefault,
          ),
          IconTextWidget(
            icon: Icons.visibility_outlined,
            value: provider.projectUiData?.watchers.toString() ?? '',
            size: AppValues.iconSize_20,
            color: AppColors.iconColorDefault,
          ),
        ],
      ),
    );
  }

  Widget _getDescription(ProjectDetailsProvider provider) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(provider.projectUiData?.description ?? '',
            style: descriptionTextStyle),
      ),
    );
  }
}
