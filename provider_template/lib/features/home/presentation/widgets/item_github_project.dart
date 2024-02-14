import 'package:flutter/material.dart';

import 'package:juno_provider_base_project/core/core.dart';

class ItemGithubProject extends StatelessWidget {
  final Item dataModel;

  const ItemGithubProject({
    required this.dataModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      child: Ripple(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppValues.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(dataModel.owner?.avatarUrl ?? ''),
                radius: AppValues.circularImageSize_30,
              ),
              const SizedBox(width: AppValues.margin_10),
              _buildDetailsView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsView() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dataModel.name ?? '',
            style: cardTitleStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: AppValues.margin_4),
          Text(
            dataModel.owner?.login ?? '',
            style: cardSubtitleStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppValues.margin_4),
          _buildForkStarWatcherView(),
        ],
      ),
    );
  }

  Widget _buildForkStarWatcherView() {
    return Row(
      children: [
        IconTextWidget(
          fileName: AppAssets.icFork,
          value: dataModel.forks.toString(),
          height: AppValues.iconSize_20,
          width: AppValues.iconSize_20,
          color: AppColors.iconColorDefault,
        ),
        IconTextWidget(
          icon: Icons.star_border,
          value: dataModel.stargazersCount.toString(),
          size: AppValues.iconSize_20,
          color: AppColors.iconColorDefault,
        ),
        IconTextWidget(
          icon: Icons.visibility_outlined,
          value: dataModel.watchers.toString(),
          size: AppValues.iconSize_20,
          color: AppColors.iconColorDefault,
        ),
      ],
    );
  }

  void _onTap() {
    navigationService.navigateTo(Routes.projectDetails,
        arguments: ProjectDetailsArgument(dataModel: dataModel));
  }
}
