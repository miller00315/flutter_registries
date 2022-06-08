import 'package:dartz/dartz.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/stream_usecase.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';

class StartWatchRegistriesUsecase
    implements StreamUsecase<List<Registry>, NoParams> {
  final RegistriesRepositoryBase _repository;

  StartWatchRegistriesUsecase(this._repository);

  @override
  Stream<Either<Failure, List<Registry>>> call(NoParams params) {
    return _repository.startWatchRegistries();
  }
}
