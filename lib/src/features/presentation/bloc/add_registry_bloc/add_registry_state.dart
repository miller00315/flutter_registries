part of 'add_registry_bloc.dart';

class AddRegistryState extends Equatable {
  final Registry registry;
  final RequestStatus status;
  final bool shouldValidate;

  AddRegistryState({
    required this.registry,
    required this.status,
    required this.shouldValidate,
  });

  @override
  List<Object> get props => [
        registry,
        status,
      ];

  factory AddRegistryState.initial() => AddRegistryState(
        registry: Registry.empty(),
        status: DoneStatus(),
        shouldValidate: false,
      );

  AddRegistryState copyWith({
    Registry? registry,
    RequestStatus? status,
    bool? shouldValidate,
  }) {
    return AddRegistryState(
      registry: registry ?? this.registry,
      status: status ?? this.status,
      shouldValidate: shouldValidate ?? this.shouldValidate,
    );
  }
}
