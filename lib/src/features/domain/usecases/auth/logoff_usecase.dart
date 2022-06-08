import 'package:dartz/dartz.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/repositories/auth_repository_interface.dart';

abstract class LogoffUsecaseInterface implements Usecase<Unit, NoParams> {}

class LogoffUsecaseImpl implements LogoffUsecaseInterface {
  final AuthRepositoryBase repository;

  LogoffUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.logoff();
  }
}
