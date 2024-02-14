import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base_view.dart';
import 'package:juno_getx_base_project/core/common_widgets/common_widgets.dart';
import 'package:juno_getx_base_project/core/domain/domain.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:juno_getx_base_project/features/home/presentation/controllers/home_controller.dart';
import 'package:juno_getx_base_project/features/home/presentation/widgets/item_github_project.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      appBarTitleText: AppStrings.appBarTitle,
    );
  }

  @override
  Widget body(BuildContext context) {
    controller.refreshController = RefreshController();

    return SmartRefresher(
        enablePullUp: true,
        onRefresh: () {
          controller.onRefreshPage();
          controller.refreshController?.refreshCompleted();
        },
        onLoading: () async {
          await controller.onLoadNextPage();
        },
        controller: controller.refreshController!,
        child: Padding(
          padding: const EdgeInsets.only(
              top: AppValues.padding,
              right: AppValues.padding,
              left: AppValues.padding),
          child: Obx(
            () => ListView.separated(
              shrinkWrap: true,
              itemCount: controller.projectList.length,
              primary: false,
              itemBuilder: (context, index) {
                final Item model = controller.projectList[index];

                return ItemGithubProject(dataModel: model);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: AppValues.smallMargin),
            ),
          ),
        ));
  }
}
