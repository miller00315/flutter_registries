import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';
import 'package:product_manager/src/features/domain/usecases/registries/stop_watch_registries_usecase.dart';

import '../../../../../test_resources/fake_entities.dart';
import 'stop_watch_registries_usecase_test.mocks.dart';

@GenerateMocks([RegistriesRepositoryBase])
main() {
  final repository = MockRegistriesRepositoryBase();

  final stopWatchRegistriesUsecase = StopWatchRegistriesUsecase(repository);

  final registry = fakeRegistries[0];

  group('StopWatchRegistriesUsecase group =>', () {
    test('''GIVEN request create [Registry]
    WHEN request success
    THEN return a [unit] on the right side''', () async {
      when(repository.stopWatchRegistries()).thenAnswer(
        (_) => Future.value(
          right(unit),
        ),
      );

      final response = await stopWatchRegistriesUsecase(NoParams());

      response.fold(
        (l) => fail('shouldn\'t return to the left side'),
        (r) => expect(r, unit),
      );
    });

    test('''GIVEN request create [Registry]
    WHEN a unexpected fail happens
    THEN return a [UnexpectedError] on the left side''', () async {
      when(repository.stopWatchRegistries()).thenAnswer(
        (_) => Future.value(
          left(UnexpectedError()),
        ),
      );

      final response = await stopWatchRegistriesUsecase(NoParams());

      response.fold(
        (l) => expect(l, UnexpectedError()),
        (r) => fail('shouldn\'t return to the left side'),
      );
    });
  });
}
