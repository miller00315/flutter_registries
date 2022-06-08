import 'dart:async';
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/features/data/datasources/registries_datasource.dart';
import 'package:product_manager/src/features/data/models/registry_model.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';
import 'package:product_manager/src/features/domain/usecases/registries/post_registry_usecase.dart';
import 'package:rxdart/rxdart.dart';

///Repositório responsável por gerenciar os registros
class RegistriesRepositoryImpl implements RegistriesRepositoryBase {
  final RegistriesDataSourceBase _registriesDataSource;

  RegistriesRepositoryImpl(this._registriesDataSource);

  @override
  Future<Either<Failure, Unit>> postRegistry(PostRegistryParams params) async {
    try {
      await _registriesDataSource.postRegistry(
        RegistryModel.fromDomain(params.registry),
      );

      return right(unit);
    } on DioError catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(UnexpectedError());
    }
  }

  @override
  Stream<Either<Failure, List<Registry>>> startWatchRegistries() async* {
    yield* _registriesDataSource
        .startWatchRegistries()
        .map(
          (registries) => right<Failure, List<Registry>>(registries),
        )
        .onErrorReturnWith(
          (error, stackTrace) => left(
            ServerFailure(),
          ),
        );
  }

  @override
  Future<Either<Failure, Unit>> stopWatchRegistries() async {
    try {
      await _registriesDataSource.stopWatchRegistries();

      return right(unit);
    } catch (e) {
      return left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, List<Registry>>> getRegistries() async {
    try {
      final registries = await _registriesDataSource.getRegistries();

      return right(registries);
    } on DioError catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(UnexpectedError());
    }
  }
}
