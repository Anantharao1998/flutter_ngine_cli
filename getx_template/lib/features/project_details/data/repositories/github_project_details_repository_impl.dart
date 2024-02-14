import 'package:dartz/dartz.dart';
import 'package:juno_getx_base_project/core/data/data.dart';
import 'package:juno_getx_base_project/core/domain/entities/item.dart';
import 'package:juno_getx_base_project/core/errors/errors.dart';
import 'package:juno_getx_base_project/features/project_details/domain/repositories/github_project_details_repository.dart';
import 'package:juno_getx_base_project/features/project_details/project_details.dart';

class GithubProjectDetailsRepositoryImpl
    with ErrorHandler
    implements GithubProjectDetailsRepository {
  final GithubProjectDetailsRemoteDataSource remoteDataSource;

  GithubProjectDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Item>> getGithubProjectDetails(
      {required String userName, required String repositoryName}) async {
    try {
      final ItemModel itemModel =
          await remoteDataSource.getGithubProjectDetails(
              userName: userName, repositoryName: repositoryName);

      return Right(itemModel);
    } catch (e) {
      if (e is Exception) {
        return Left(mapExceptionToFailure(e));
      }

      return Left(UnhandledFailure(
          className: e.runtimeType.toString(), message: e.toString()));
    }
  }
}
