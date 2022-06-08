import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:product_manager/src/core/error/failures.dart';
import 'package:product_manager/src/core/status/request_status.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/domain/usecases/registries/post_registry_usecase.dart';

part 'add_registry_event.dart';
part 'add_registry_state.dart';

class AddRegistryBloc extends Bloc<AddRegistryEvent, AddRegistryState> {
  final PostRegistryUsecase postRegistryUsecase;

  AddRegistryBloc(this.postRegistryUsecase)
      : super(AddRegistryState.initial()) {
    on<AddRegistryEvent>((event, emit) async {
      if (event is PostRegistryEvent) {
        Either<Failure, Unit>? failureOrSuccess;

        if (state.registry.validateName() == null) {
          failureOrSuccess =
              await postRegistryUsecase(PostRegistryParams(state.registry));
        } else {
          failureOrSuccess = left(EmptyFieldError());
        }

        failureOrSuccess.fold(
          (failure) => emit(
            state.copyWith(
              status: ErrorStatus(),
              shouldValidate: true,
            ),
          ),
          (_) => emit(
            state.copyWith(status: DoneStatus()),
          ),
        );
      }
    });
  }
}
