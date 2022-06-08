import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manager/injection_container.dart';
import 'package:product_manager/src/features/presentation/bloc/add_registry_bloc/add_registry_bloc.dart';
import 'package:product_manager/src/features/presentation/pages/add_registry/widgets/add_registry_body.dart';

class AddRegistry extends StatelessWidget {
  const AddRegistry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddRegistryBloc>(
      create: (_) => serviceLocator<AddRegistryBloc>(),
      child: const AddRegistryBody(),
    );
  }
}
