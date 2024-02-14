import 'package:dartz/dartz.dart';

import 'package:juno_provider_base_project/core/errors/errors.dart';
import 'package:juno_provider_base_project/features/home/data/datasources/github_repo_list_remote_datasource.dart';
import 'package:juno_provider_base_project/features/home/data/models/github_repo_list_model.dart';
import 'package:juno_provider_base_project/features/home/domain/entities/github_repo_list.dart';
import 'package:juno_provider_base_project/features/home/domain/repositories/github_repo_list_repository.dart';
import 'package:juno_provider_base_project/features/home/domain/usecases/get_github_project.dart';

class GithubRepoListRepositoryImpl
    with ErrorHandler
    implements GithubRepoListRepository {
  GithubRepoListRepositoryImpl({required this.remoteDataSource});

  final GithubRepoListRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, GithubRepoList>> getGithubProject(
      {required GithubRepoListQueryParam queryParam}) async {
    try {
      final GithubRepoListModel githubRepoListModel =
          await remoteDataSource.getGithubProject(queryParam: queryParam);

      return Right(githubRepoListModel);
    } catch (e) {
      if (e is Exception) {
        return Left(mapExceptionToFailure(e));
      }

      return Left(UnhandledFailure(
          className: e.runtimeType.toString(), message: e.toString()));
    }
  }
}
