import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';

///Responsável por efetuar a criação de um novo [registry]
class PostRegistryUsecase implements Usecase<Unit, PostRegistryParams> {
  final RegistriesRepositoryBase _repository;

  PostRegistryUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(PostRegistryParams params) async {
    return await _repository.postRegistry(params);
  }
}

/// Parametros necessário para a criação de um novo registro.
/// [registry] é o novo registro a ser salvo
class PostRegistryParams extends Equatable {
  final Registry registry;

  const PostRegistryParams(this.registry);

  @override
  List<Object?> get props => [
        registry,
      ];
}
