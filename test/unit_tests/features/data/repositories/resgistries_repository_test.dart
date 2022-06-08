import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/features/data/datasources/registries_datasource.dart';
import 'package:product_manager/src/features/data/models/registry_model.dart';
import 'package:product_manager/src/features/data/repositories/registries_repository_impl.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/usecases/registries/post_registry_usecase.dart';

import '../../../../test_resources/fake_entities.dart';
import 'resgistries_repository_test.mocks.dart';

@GenerateMocks([RegistriesDataSourceBase])
main() {
  final registriesDataSource = MockRegistriesDataSourceBase();

  final registriesRepository = RegistriesRepositoryImpl(registriesDataSource);

  final registry = fakeRegistries[0];

  final registryModel = RegistryModel.fromDomain(registry);

  group('RegistriesRepository group => \n', () {
    tearDown(() {
      reset(registriesDataSource);
    });

    test('''GIVEN call [registriesRepository.getRegistries]
    WHEN request is success
    THEN return a list of [Registry] on the right side
    ''', () async {
      when(registriesDataSource.getRegistries())
          .thenAnswer((_) => Future.value([]));

      final res = await registriesRepository.getRegistries();

      res.fold(
        (l) => fail('shouldn\'t return on the left side'),
        (r) => expect(r, []),
      );

      verify(registriesDataSource.getRegistries()).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN call [registriesRepository.getRegistries]
    WHEN request fail
    THEN return a [ServerFailure] on the left side
    ''', () async {
      when(registriesDataSource.getRegistries()).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final res = await registriesRepository.getRegistries();

      res.fold(
        (l) => expect(l, ServerFailure()),
        (r) => fail('shouldn\'t return on the left side'),
      );

      verify(registriesDataSource.getRegistries()).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN call [registriesRepository.getRegistries]
    WHEN unexpected fail happens
    THEN return a [UnexpectedError] on the left side
    ''', () async {
      when(registriesDataSource.getRegistries()).thenThrow(Exception('error'));

      final res = await registriesRepository.getRegistries();

      res.fold(
        (l) => expect(l, UnexpectedError()),
        (r) => fail('shouldn\'t return on the left side'),
      );

      verify(registriesDataSource.getRegistries()).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN call [registriesRepository.startWatch]
    THEN return a [Stream<Either<Failure, List<Registry>>>]
    ''', () async {
      final res = registriesRepository.startWatchRegistries();

      expect(res, isInstanceOf<Stream<Either<Failure, List<Registry>>>>());
    });

    test('''GIVEN wait a new list of [Registry]
    WHEN data is received
    THEN stream should emit a list of [Registry] on the right side
    ''', () async {
      final testStream =
          Stream<List<Registry>>.fromIterable([fakeRegistryModels]);

      when(registriesDataSource.startWatchRegistries())
          .thenAnswer((_) => testStream);

      final stream = registriesRepository.startWatchRegistries();

      stream.listen((event) {
        expect(event, Right(fakeRegistryModels));
      });

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN wait a new list of [Registry]
    WHEN error happens when receive data
    THEN stream should emit a [ServerFailure] on the right side
    ''', () async {
      final testStream = Stream<List<Registry>>.error(Exception('error'));

      when(registriesDataSource.startWatchRegistries())
          .thenAnswer((_) => testStream);

      final stream = registriesRepository.startWatchRegistries();

      stream.listen((event) {
        expect(event, Left(ServerFailure()));
      });

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN a new [Registry] to save
    WHEN save request success
    THEN should return a [unit] on the right side
    ''', () async {
      when(
        registriesDataSource.postRegistry(registryModel),
      ).thenAnswer((_) => Future.value());

      final response =
          await registriesRepository.postRegistry(PostRegistryParams(registry));

      response.fold(
        (l) => fail('shouldn\'t return on the left side'),
        (r) => expect(r, unit),
      );

      verify(registriesDataSource.postRegistry(registryModel)).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN a new [Registry] to save
    WHEN save request fail
    THEN should return a [ServerFailure] on the left side
    ''', () async {
      final registry = fakeRegistries[0];

      final registryModel = RegistryModel.fromDomain(registry);

      when(
        registriesDataSource.postRegistry(registryModel),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final response =
          await registriesRepository.postRegistry(PostRegistryParams(registry));

      response.fold(
        (l) => ServerFailure(),
        (r) => fail('shouldn\'t return on the left side'),
      );

      verify(registriesDataSource.postRegistry(registryModel)).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN a new [Registry] to save
    WHEN a unexpected fail happens
    THEN should return a [UnexpectedError] on the left side
    ''', () async {
      when(
        registriesDataSource.postRegistry(registryModel),
      ).thenThrow(
        Exception('Error'),
      );

      final response =
          await registriesRepository.postRegistry(PostRegistryParams(registry));

      response.fold(
        (l) => UnexpectedError(),
        (r) => fail('shouldn\'t return on the right side'),
      );

      verify(registriesDataSource.postRegistry(registryModel)).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN call [registriesRepository.stopWatchRegistries]
    WHEN stop list is success
    THEN should return a [unit] on the right side
    ''', () async {
      when(registriesDataSource.stopWatchRegistries())
          .thenAnswer((_) => Future.value());

      final response = await registriesRepository.stopWatchRegistries();

      response.fold(
        (l) => fail('shouldn\'t return on the left side'),
        (r) => unit,
      );

      verify(registriesDataSource.stopWatchRegistries()).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });

    test('''GIVEN call [registriesRepository.stopWatchRegistries]
    WHEN stop watch is fail
    THEN should return a [unit] on the right side
    ''', () async {
      when(registriesDataSource.stopWatchRegistries())
          .thenThrow(Exception('Error'));

      final response = await registriesRepository.stopWatchRegistries();

      response.fold(
        (l) => UnexpectedError(),
        (r) => fail('shouldn\'t return on the right side'),
      );

      verify(registriesDataSource.stopWatchRegistries()).called(1);

      verifyNoMoreInteractions(registriesDataSource);
    });
  });
}
