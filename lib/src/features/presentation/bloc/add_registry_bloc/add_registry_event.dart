part of 'add_registry_bloc.dart';

abstract class AddRegistryEvent extends Equatable {
  const AddRegistryEvent();

  @override
  List<Object> get props => [];
}

class PostRegistryEvent extends AddRegistryEvent {}
