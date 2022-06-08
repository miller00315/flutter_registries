import 'package:dartz/dartz.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/entities/auth/user.dart';
import 'package:product_manager/src/features/domain/repositories/auth_repository_interface.dart';

abstract class GetLoggedInUserUsecaseInterface
    implements Usecase<User, NoParams> {}

class GetLoggedInUsecaseImpl implements GetLoggedInUserUsecaseInterface {
  final AuthRepositoryBase repository;

  GetLoggedInUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.geLoggedInUser();
  }
}
