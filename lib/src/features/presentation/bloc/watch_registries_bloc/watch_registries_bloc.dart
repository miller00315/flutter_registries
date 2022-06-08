import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/status/request_status.dart';
import 'package:product_manager/src/core/usecases/usecase.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/usecases/registries/get_registries_usecase.dart';
import 'package:product_manager/src/features/domain/usecases/registries/start_watch_registries_usecase.dart';
import 'package:product_manager/src/features/domain/usecases/registries/stop_watch_registries_usecase.dart';

part 'watch_registries_event.dart';
part 'watch_registries_state.dart';

class WatchRegistriesBloc
    extends Bloc<WatchRegistriesEvent, WatchRegistriesState> {
  final StartWatchRegistriesUsecase startWatchRegistryUsecase;
  final StopWatchRegistriesUsecase stopWatchRegistriesUsecase;
  final GetRegistriesUsecase getRegistriesUsecase;

  StreamSubscription<Either<Failure, List<Registry>>>? registriesStream;

  @override
  close() async {
    registriesStream?.cancel();

    stopWatchRegistriesUsecase(NoParams());

    super.close();
  }

  WatchRegistriesBloc(
    this.startWatchRegistryUsecase,
    this.stopWatchRegistriesUsecase,
    this.getRegistriesUsecase,
  ) : super(WatchRegistriesState.initial()) {
    on<WatchRegistriesEvent>((event, emit) async {
      if (event is StartWatchRegistriesEvent) {
        await registriesStream?.cancel();

        emit(
          state.copyWith(
            status: InProgressStatus(),
          ),
        );

        registriesStream =
            startWatchRegistryUsecase(NoParams()).listen((e) async {
          e.fold(
            (failure) => add(ReceiveRegistriesEvent(left(failure))),
            (registries) => add(ReceiveRegistriesEvent(right(registries))),
          );
        });
      }

      if (event is ReceiveRegistriesEvent) {
        event.failureOrRegistries.fold(
          (failure) => emit(state.copyWith(status: ErrorStatus())),
          (registries) => emit(
            state.copyWith(
              status: DoneStatus(),
              registries: [...state.registries, ...registries],
            ),
          ),
        );
      }

      if (event is GetRegistriesEvent) {
        emit(state.copyWith(status: InProgressStatus()));

        final failureOrRegistries = await getRegistriesUsecase(NoParams());

        failureOrRegistries.fold(
          (l) => emit(
            state.copyWith(
              status: ErrorStatus(),
            ),
          ),
          (registries) => emit(
            state.copyWith(
              registries: registries,
              status: DoneStatus(),
            ),
          ),
        );
      }
    });
  }
}
