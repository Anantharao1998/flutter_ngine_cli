import 'package:dartz/dartz.dart';
import 'package:juno_provider_base_project/core/domain/domain.dart';
import 'package:juno_provider_base_project/core/errors/errors.dart';

abstract class GithubProjectDetailsRepository {
  Future<Either<Failure, Item>> getGithubProjectDetails(
      {required String userName, required String repositoryName});
}
