import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:juno_getx_base_project/core/base/base.dart';
import 'package:juno_getx_base_project/core/domain/domain.dart';
import 'package:juno_getx_base_project/core/errors/failures.dart';
import 'package:juno_getx_base_project/features/project_details/domain/repositories/github_project_details_repository.dart';

class GetGithubProjectDetails
    implements UseCase<Item, GithubProjectDetailsParam> {
  final GithubProjectDetailsRepository repository;

  GetGithubProjectDetails({required this.repository});

  @override
  Future<Either<Failure, Item>> call(
      {required GithubProjectDetailsParam params}) async {
    return await repository.getGithubProjectDetails(
        userName: params.userName, repositoryName: params.repositoryName);
  }
}

class GithubProjectDetailsParam extends Equatable {
  final String userName;
  final String repositoryName;

  const GithubProjectDetailsParam(
      {required this.userName, required this.repositoryName});

  @override
  List<Object?> get props => [userName, repositoryName];
}
