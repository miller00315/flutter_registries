import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manager/injection_container.dart';
import 'package:product_manager/src/features/presentation/bloc/watch_registries_bloc/watch_registries_bloc.dart';
import 'package:product_manager/src/features/presentation/pages/registries/widgets/registries_body.dart';

class Registries extends StatelessWidget {
  const Registries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WatchRegistriesBloc>(
      create: (_) => serviceLocator<WatchRegistriesBloc>()
        ..add(StartWatchRegistriesEvent())
        ..add(GetRegistriesEvent()),
      child: const RegistriesBody(),
    );
  }
}
