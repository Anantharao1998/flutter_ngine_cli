import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:juno_provider_base_project/core/base/base_use_cases.dart';
import 'package:juno_provider_base_project/core/errors/failures.dart';
import 'package:juno_provider_base_project/core/values/values.dart';
import 'package:juno_provider_base_project/features/home/domain/home_feature_domain.dart';
import 'package:juno_provider_base_project/features/home/domain/repositories/github_repo_list_repository.dart';

class GetGithubProject
    implements UseCase<GithubRepoList, GithubRepoListQueryParam> {
  GetGithubProject({required this.repository});

  final GithubRepoListRepository repository;

  @override
  Future<Either<Failure, GithubRepoList>> call(
      {required GithubRepoListQueryParam params}) async {
    return await repository.getGithubProject(queryParam: params);
  }
}

class GithubRepoListQueryParam extends Equatable {
  const GithubRepoListQueryParam({
    required this.searchKeyWord,
    this.perPage = AppValues.defaultPageSize,
    this.pageNumber = AppValues.defaultPageNumber,
  });

  final int pageNumber;
  final int perPage;
  final String searchKeyWord;

  @override
  List<Object?> get props => [searchKeyWord, perPage, pageNumber];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q'] = searchKeyWord;
    data['per_page'] = perPage;
    data['page'] = pageNumber;

    return data;
  }
}
