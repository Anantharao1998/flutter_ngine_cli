import 'package:dio/dio.dart' as dio;
import 'package:juno_provider_base_project/core/base/base.dart';
import 'package:juno_provider_base_project/core/values/api_constants.dart';
import 'package:juno_provider_base_project/features/home/data/models/github_repo_list_model.dart';
import 'package:juno_provider_base_project/features/home/domain/usecases/get_github_project.dart';

abstract class GithubRepoListRemoteDataSource {
  Future<GithubRepoListModel> getGithubProject(
      {required GithubRepoListQueryParam queryParam});
}

class GithubListRemoteDataSourceImpl extends BaseRemoteDataSource
    implements GithubRepoListRemoteDataSource {
  @override
  Future<GithubRepoListModel> getGithubProject(
      {required GithubRepoListQueryParam queryParam}) {
    final Future<dio.Response<dynamic>> dioCall = dioClient
        .get(ApiConstants.githubListUri, queryParameters: queryParam.toJson());

    return callApiWithErrorParser(dioCall)
        .then((response) => _parseGithubProjectSearchResponse(response.data));
  }

  GithubRepoListModel _parseGithubProjectSearchResponse(data) {
    return GithubRepoListModel.fromJson(data);
  }
}
