import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base.dart';
import 'package:juno_getx_base_project/core/domain/domain.dart';
import 'package:juno_getx_base_project/core/errors/errors.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:juno_getx_base_project/features/home/domain/usecases/get_github_project.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  HomeController({required this.getGithubProject});

  final GetGithubProject getGithubProject;

  final RxList<Item> _githubProjectList = RxList.empty();
  final RxList<Item> _loadMoreList = RxList.empty();

  List<Item> get projectList => _githubProjectList.toList();

  RefreshController? refreshController;

  int _pageNumber = AppValues.defaultPageNumber;
  int? _totalCount;
  int? get totalCount => _totalCount;

  @override
  void onInit() {
    _getGithubGetxProjectList();
    super.onInit();
  }

  Future _getGithubGetxProjectList({bool showLoading = true}) async {
    if (showLoading) {
      setLoading();
    }

    final GithubRepoListQueryParam queryParam = GithubRepoListQueryParam(
        searchKeyWord: 'flutter getx template', pageNumber: _pageNumber);

    final Either<Failure, GithubRepoList> result =
        await getGithubProject.call(params: queryParam);

    result.fold((l) {
      if (!showLoading) {
        refreshController?.loadFailed();
      }
      setError(l);
    }, (r) {
      _handleProjectListResponseSuccess(r);
    });

    setSuccess();
  }

  void _handleProjectListResponseSuccess(GithubRepoList response) {
    final List<Item>? repoList = response.items;

    _totalCount = response.totalCount;

    if (repoList != null) {
      _loadMoreList.addAll(repoList);

      _githubProjectList(_loadMoreList);
    }
  }

  void onRefreshPage() {
    _getGithubGetxProjectList(showLoading: false);
  }

  Future<void> onLoadNextPage() async {
    _pageNumber++;

    if (_loadMoreList.isEmpty) {
      return;
    }

    if (_loadMoreList.length < totalCount!) {
      await _getGithubGetxProjectList(showLoading: false);
      refreshController?.loadComplete();
    } else {
      refreshController?.loadNoData();
    }
  }
}
