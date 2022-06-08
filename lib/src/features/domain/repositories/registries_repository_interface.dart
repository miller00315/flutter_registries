import 'package:dartz/dartz.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/usecases/registries/post_registry_usecase.dart';

/// Interface responsável por definiar o contrato para o repositório de registros.
/// [postRegistry] envia o novo regstro paar ser salvo,
/// [startWatchRegistries] inicia a verificação de registros.
/// [stopWatchRegistries] interrompe a verificação de registros.
/// [getRegistries] solicita lista de registro registros.
abstract class RegistriesRepositoryBase {
  /// Recebe [params] que contém uma entidade [registry],
  /// retorna uma [Failure] em caso de erro,
  /// ou uma [Unit] em caso de sucesso.
  Future<Either<Failure, Unit>> postRegistry(PostRegistryParams params);

  /// Retorna uma [Failure] em caso de erro,
  /// ou uma [Stream] do tipo [List] de [Registry] em caso de sucesso
  Stream<Either<Failure, List<Registry>>> startWatchRegistries();

  /// Retorna uma [Failure] em caso de erro,
  /// ou uma [Unit] em caso de sucesso.
  Future<Either<Failure, Unit>> stopWatchRegistries();

  /// Retorna uma [Failure] em caso de erro,
  /// ou uma [List] de [Regsitry] em caso de sucesso
  Future<Either<Failure, List<Registry>>> getRegistries();
}
