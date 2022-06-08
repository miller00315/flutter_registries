import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';
import 'package:product_manager/src/features/domain/usecases/registries/start_watch_registries_usecase.dart';

import '../../../../../test_resources/fake_entities.dart';
import 'start_watch_registries_usecase_test.mocks.dart';

@GenerateMocks([RegistriesRepositoryBase])
main() {
  final repository = MockRegistriesRepositoryBase();

  final startWatchRegistriesUsecase = StartWatchRegistriesUsecase(repository);

  group('StartWatchRegistriesUsecase group =>', () {
    test('''GIVEN request create [Registry]
    WHEN request success
    THEN return a [unit] on the right side''', () {
      final testStream = Stream<Either<Failure, List<Registry>>>.fromIterable(
          [right(fakeRegistries)]);

      when(repository.startWatchRegistries()).thenAnswer(
        (_) => testStream,
      );

      final response = startWatchRegistriesUsecase(NoParams());

      expect(response, emitsInAnyOrder([right(fakeRegistries)]));
    });

    test('''GIVEN request create [Registry]
    WHEN a unexpected fail happens
    THEN return a [UnexpectedError] on the left side''', () {
      final testStream = Stream<Either<Failure, List<Registry>>>.fromIterable(
          [left(UnexpectedError())]);

      when(repository.startWatchRegistries()).thenAnswer(
        (_) => testStream,
      );

      final response = startWatchRegistriesUsecase(NoParams());

      expect(response, emitsInAnyOrder([left(UnexpectedError())]));
    });

    test('''GIVEN request create [Registry]
    WHEN a request fail happens
    THEN return a [ServerFailure] on the left side''', () {
      final testStream = Stream<Either<Failure, List<Registry>>>.fromIterable(
          [left(ServerFailure())]);

      when(repository.startWatchRegistries()).thenAnswer(
        (_) => testStream,
      );

      final response = startWatchRegistriesUsecase(NoParams());

      expect(response, emitsInAnyOrder([left(ServerFailure())]));
    });
  });
}
