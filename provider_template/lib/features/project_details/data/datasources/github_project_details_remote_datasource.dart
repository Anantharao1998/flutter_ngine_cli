import 'package:dio/dio.dart' as dio;
import 'package:juno_provider_base_project/core/base/base.dart';
import 'package:juno_provider_base_project/core/data/data.dart';
import 'package:juno_provider_base_project/core/values/api_constants.dart';

abstract class GithubProjectDetailsRemoteDataSource {
  Future<ItemModel> getGithubProjectDetails(
      {required String userName, required String repositoryName});
}

class GithubProjectDetailsRemoteDataSourceImpl extends BaseRemoteDataSource
    implements GithubProjectDetailsRemoteDataSource {
  @override
  Future<ItemModel> getGithubProjectDetails(
      {required String userName, required String repositoryName}) {
    final Future<dio.Response<dynamic>> dioCall = dioClient
        .get('${ApiConstants.projectDetailsUri}$userName/$repositoryName');

    return callApiWithErrorParser(dioCall)
        .then((response) => _parseGithubProjectDetailsResponse(response.data));
  }

  ItemModel _parseGithubProjectDetailsResponse(response) {
    return ItemModel.fromJson(response);
  }
}
