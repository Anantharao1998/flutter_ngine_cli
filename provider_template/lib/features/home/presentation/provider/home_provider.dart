import 'package:dartz/dartz.dart';
import 'package:juno_provider_base_project/core/core.dart';
import 'package:juno_provider_base_project/features/home/home.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeProvider extends BaseProvider {
  HomeProvider({required this.getGithubProject});

  final GetGithubProject getGithubProject;

  final List<Item> _githubProjectList = [];
  final List<Item> _loadMoreList = [];

  List<Item> get projectList => _githubProjectList.toList();

  RefreshController? refreshController;

  int _pageNumber = AppValues.defaultPageNumber;
  int? _totalCount;
  int? get totalCount => _totalCount;

  void onInit() {
    refreshController = RefreshController();
    _getGithubGetxProjectList();
  }

  Future _getGithubGetxProjectList({bool showLoading = true}) async {
    if (showLoading) {
      setLoading();
    }

    final GithubRepoListQueryParam queryParam = GithubRepoListQueryParam(
        searchKeyWord: 'flutter provider template', pageNumber: _pageNumber);

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
  }

  void _handleProjectListResponseSuccess(GithubRepoList response) {
    final List<Item>? repoList = response.items;

    _totalCount = response.totalCount;

    if (repoList != null) {
      _loadMoreList.addAll(repoList);

      _githubProjectList.addAll(_loadMoreList);
    }

    setSuccess();
  }

  void onRefreshPage() {
    _pageNumber = AppValues.defaultPageNumber;
    if (_githubProjectList.isNotEmpty) {
      _githubProjectList.clear();
    }
    refreshController?.resetNoData();
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
