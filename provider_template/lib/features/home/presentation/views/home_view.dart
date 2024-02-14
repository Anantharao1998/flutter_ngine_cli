import 'package:flutter/material.dart';

import 'package:juno_provider_base_project/core/core.dart';
import 'package:juno_provider_base_project/features/home/home.dart';
import 'package:juno_provider_base_project/features/home/presentation/widgets/item_github_project.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends BaseView<HomeProvider> {
  HomeView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      appBarTitleText: AppStrings.appBarTitle,
    );
  }

  Widget _buildBodyContent(HomeProvider provider, ViewState state) {
    switch (state) {
      case ViewState.loading:
        return const Loading();

      case ViewState.success:
        return _body(provider);

      default:
        return Container();
    }
  }

  Widget _body(HomeProvider provider) {
    return SmartRefresher(
      enablePullUp: true,
      onRefresh: () {
        provider.onRefreshPage();
        provider.refreshController?.refreshCompleted();
      },
      onLoading: () async {
        await provider.onLoadNextPage();
      },
      controller: provider.refreshController!,
      child: Padding(
        padding: const EdgeInsets.only(
            top: AppValues.padding,
            right: AppValues.padding,
            left: AppValues.padding),
        child: Selector<HomeProvider, List<Item>>(
          selector: (__, p) => p.projectList,
          builder: (context, projectList, child) => ListView.separated(
            shrinkWrap: true,
            itemCount: projectList.length,
            primary: false,
            itemBuilder: (context, index) {
              final Item model = projectList[index];

              return ItemGithubProject(dataModel: model);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: AppValues.smallMargin),
          ),
        ),
      ),
    );
  }

  @override
  HomeProvider onInit(HomeProvider provider, BuildContext context) {
    // make initial API call
    provider.onInit();

    // show dialog or snackbar or bottomsheet here
    if (provider.viewState == ViewState.error &&
        provider.errorMessage.isNotEmpty) {
      final snackBar = SnackBar(content: Text(provider.errorMessage));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return super.onInit(provider, context);
  }

  @override
  Widget body(BuildContext context, HomeProvider provider) {
    return Selector<HomeProvider, ViewState>(
      selector: (p0, p1) => p1.viewState,
      builder: (context, state, child) => _buildBodyContent(provider, state),
    );
  }
}
