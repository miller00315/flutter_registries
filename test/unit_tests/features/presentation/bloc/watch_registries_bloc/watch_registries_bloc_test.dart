import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/status/request_status.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/usecases/registries/get_registries_usecase.dart';
import 'package:product_manager/src/features/domain/usecases/registries/start_watch_registries_usecase.dart';
import 'package:product_manager/src/features/domain/usecases/registries/stop_watch_registries_usecase.dart';
import 'package:product_manager/src/features/presentation/bloc/watch_registries_bloc/watch_registries_bloc.dart';

import '../../../../../test_resources/fake_entities.dart';
import 'watch_registries_bloc_test.mocks.dart';

@GenerateMocks([
  StartWatchRegistriesUsecase,
  StopWatchRegistriesUsecase,
  GetRegistriesUsecase,
])
main() {
  final startWatchRegistries = MockStartWatchRegistriesUsecase();
  final stopWatchRegistries = MockStopWatchRegistriesUsecase();
  final getRegistries = MockGetRegistriesUsecase();

  group('WatchRegistriesBloc group =>', () {
    tearDown(() {
      reset(startWatchRegistries);
      reset(stopWatchRegistries);
      reset(getRegistries);
    });
    blocTest<WatchRegistriesBloc, WatchRegistriesState>(
      '''GIVEN request a list of [Registry]
    WHEN request success
    THEN should emit a [DoneStatus] and a list of [Regsitry]''',
      build: () => WatchRegistriesBloc(
        startWatchRegistries,
        stopWatchRegistries,
        getRegistries,
      ),
      setUp: () {
        final testStream = Stream<Either<Failure, List<Registry>>>.fromIterable(
            [right(fakeRegistries)]);

        when(
          startWatchRegistries(NoParams()),
        ).thenAnswer(
          (_) => testStream,
        );

        when(stopWatchRegistries(NoParams())).thenAnswer(
          (_) => Future.value(
            right(unit),
          ),
        );
      },
      act: (bloc) => bloc.add(StartWatchRegistriesEvent()),
      expect: () => [
        WatchRegistriesState(registries: const [], status: InProgressStatus()),
        WatchRegistriesState(registries: fakeRegistries, status: DoneStatus()),
      ],
    );

    blocTest<WatchRegistriesBloc, WatchRegistriesState>(
        '''GIVEN request a list of [Registry]
    WHEN request success
    THEN first should emit a [DoneStatus] and after a [ErrorStatus]''',
        build: () => WatchRegistriesBloc(
              startWatchRegistries,
              stopWatchRegistries,
              getRegistries,
            ),
        setUp: () {
          final testStream =
              Stream<Either<Failure, List<Registry>>>.fromIterable(
                  [left(ServerFailure())]);

          when(
            startWatchRegistries(NoParams()),
          ).thenAnswer(
            (_) => testStream,
          );

          when(stopWatchRegistries(NoParams())).thenAnswer(
            (_) => Future.value(
              right(unit),
            ),
          );
        },
        act: (bloc) => bloc.add(StartWatchRegistriesEvent()),
        expect: () => [
              WatchRegistriesState(
                  registries: const [], status: InProgressStatus()),
              WatchRegistriesState(registries: const [], status: ErrorStatus()),
            ],
        verify: (_) {
          verify(startWatchRegistries(NoParams())).called(1);

          verify(stopWatchRegistries(NoParams())).called(1);

          verifyNoMoreInteractions(startWatchRegistries);

          verifyNoMoreInteractions(stopWatchRegistries);
        });

    blocTest<WatchRegistriesBloc, WatchRegistriesState>(
        '''GIVEN request a list of [Registry]
    WHEN request success
    THEN first should emit  a [DoneStatus]''',
        build: () => WatchRegistriesBloc(
              startWatchRegistries,
              stopWatchRegistries,
              getRegistries,
            ),
        setUp: () {
          when(getRegistries(NoParams())).thenAnswer(
            (_) => Future.value(
              right(fakeRegistries),
            ),
          );

          when(stopWatchRegistries(NoParams())).thenAnswer(
            (_) => Future.value(
              right(unit),
            ),
          );
        },
        act: (bloc) => bloc.add(GetRegistriesEvent()),
        expect: () => [
              WatchRegistriesState(
                  registries: const [], status: InProgressStatus()),
              WatchRegistriesState(
                  registries: fakeRegistries, status: DoneStatus()),
            ],
        verify: (_) {
          verify(getRegistries(NoParams())).called(1);

          verify(stopWatchRegistries(NoParams())).called(1);

          verifyNoMoreInteractions(startWatchRegistries);

          verifyNoMoreInteractions(stopWatchRegistries);
        });

    blocTest<WatchRegistriesBloc, WatchRegistriesState>(
        '''GIVEN request a list of [Registry]
    WHEN request success
    THEN first should emit  a [ErrorStatus]''',
        build: () => WatchRegistriesBloc(
              startWatchRegistries,
              stopWatchRegistries,
              getRegistries,
            ),
        setUp: () {
          when(getRegistries(NoParams())).thenAnswer(
            (_) => Future.value(
              left(ServerFailure()),
            ),
          );

          when(stopWatchRegistries(NoParams())).thenAnswer(
            (_) => Future.value(
              right(unit),
            ),
          );
        },
        act: (bloc) => bloc.add(GetRegistriesEvent()),
        expect: () => [
              WatchRegistriesState(
                  registries: const [], status: InProgressStatus()),
              WatchRegistriesState(registries: const [], status: ErrorStatus()),
            ],
        verify: (_) {
          verify(getRegistries(NoParams())).called(1);

          verify(stopWatchRegistries(NoParams())).called(1);

          verifyNoMoreInteractions(startWatchRegistries);

          verifyNoMoreInteractions(stopWatchRegistries);
        });
  });
}
