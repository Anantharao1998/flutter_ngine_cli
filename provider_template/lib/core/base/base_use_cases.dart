import 'package:dartz/dartz.dart';
import 'package:juno_provider_base_project/core/errors/errors.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UseCaseNoParamsNoFuture<Type> {
  Either<Failure, Type> call();
}

abstract class UseCaseNoFuture<Type, Params> {
  Either<Failure, Type> call({Params params});
}

abstract class UseCaseNoFutureNoParams<Type> {
  Either<Failure, Type> call();
}

abstract class UseCaseNoEither<Type, Params> {
  Future<Type> call({required Params params});
}

abstract class UseCaseNoEitherNoParams<Type> {
  Future<Type> call();
}

abstract class UseCaseNoParamsNoFutureNoEither<Type> {
  Type call();
}
