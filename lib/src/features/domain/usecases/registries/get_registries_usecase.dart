import 'package:dartz/dartz.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';

class GetRegistriesUsecase implements Usecase<List<Registry>, NoParams> {
  final RegistriesRepositoryBase _repository;

  GetRegistriesUsecase(this._repository);

  @override
  Future<Either<Failure, List<Registry>>> call(NoParams params) async {
    return await _repository.getRegistries();
  }
}
