part of 'watch_registries_bloc.dart';

abstract class WatchRegistriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartWatchRegistriesEvent extends WatchRegistriesEvent {}

class ReceiveRegistriesEvent extends WatchRegistriesEvent {
  final Either<Failure, List<Registry>> failureOrRegistries;

  ReceiveRegistriesEvent(this.failureOrRegistries);

  @override
  List<Object> get props => [failureOrRegistries];
}
