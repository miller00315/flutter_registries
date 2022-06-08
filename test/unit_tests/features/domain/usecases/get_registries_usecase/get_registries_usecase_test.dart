import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';
import 'package:product_manager/src/features/domain/usecases/registries/get_registries_usecase.dart';

import '../../../../../test_resources/fake_entities.dart';
import 'get_registries_usecase_test.mocks.dart';

@GenerateMocks([RegistriesRepositoryBase])
main() {
  final repository = MockRegistriesRepositoryBase();

  final getRegistriesUsecase = GetRegistriesUsecase(repository);
  group('GetRegistriesUsecase group =>', () {
    test('''GIVEN request a list of [Registry]
    WHEN request success
    THEN return a list of [Registry] on the right side''', () async {
      when(repository.getRegistries()).thenAnswer(
        (realInvocation) => Future.value(
          right(fakeRegistries),
        ),
      );

      final response = await getRegistriesUsecase(NoParams());

      response.fold(
        (l) => fail('shouldn\'t return to the left side'),
        (r) => expect(r, fakeRegistries),
      );
    });

    test('''GIVEN request a list of [Registry]
    WHEN request fail
    THEN return a [ServerFailure] on the left side''', () async {
      when(repository.getRegistries()).thenAnswer(
        (realInvocation) => Future.value(
          left(ServerFailure()),
        ),
      );

      final response = await getRegistriesUsecase(NoParams());

      response.fold(
        (l) => expect(l, ServerFailure()),
        (r) => fail('shouldn\'t return to the left side'),
      );
    });

    test('''GIVEN request a list of [Registry]
    WHEN a unexpected fail happens
    THEN return a [UnexpectedError] on the left side''', () async {
      when(repository.getRegistries()).thenAnswer(
        (realInvocation) => Future.value(
          left(UnexpectedError()),
        ),
      );

      final response = await getRegistriesUsecase(NoParams());

      response.fold(
        (l) => expect(l, UnexpectedError()),
        (r) => fail('shouldn\'t return to the left side'),
      );
    });
  });
}
