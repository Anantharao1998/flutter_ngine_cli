import 'package:dartz/dartz.dart';
import 'package:juno_provider_base_project/core/errors/errors.dart';
import 'package:juno_provider_base_project/features/home/domain/entities/github_repo_list.dart';
import 'package:juno_provider_base_project/features/home/domain/usecases/get_github_project.dart';

abstract class GithubRepoListRepository {
  Future<Either<Failure, GithubRepoList>> getGithubProject(
      {required GithubRepoListQueryParam queryParam});
}
