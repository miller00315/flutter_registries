part of 'watch_registries_bloc.dart';

class WatchRegistriesState extends Equatable {
  final List<Registry> registries;
  final RequestStatus status;

  const WatchRegistriesState({
    required this.registries,
    required this.status,
  });

  @override
  List<Object> get props => [
        registries,
        status,
      ];

  factory WatchRegistriesState.initial() => WatchRegistriesState(
        registries: const [],
        status: DoneStatus(),
      );

  WatchRegistriesState copyWith({
    List<Registry>? registries,
    RequestStatus? status,
  }) {
    return WatchRegistriesState(
      registries: registries ?? this.registries,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => '''
    WatchRegistriesState {
      registries: $registries,
      status: $status,
    }
  ''';
}
