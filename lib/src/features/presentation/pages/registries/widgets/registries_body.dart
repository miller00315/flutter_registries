import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manager/src/core/status/request_status.dart';
import 'package:product_manager/src/features/presentation/bloc/watch_registries_bloc/watch_registries_bloc.dart';
import 'package:product_manager/src/features/presentation/pages/add_registry/add_registry.dart';
import 'package:product_manager/src/features/presentation/pages/registries/widgets/registries_list/registries_list.dart';

class RegistriesBody extends StatelessWidget {
  const RegistriesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WatchRegistriesBloc, WatchRegistriesState>(
        builder: (context, state) {
          if (state.status is DoneStatus) {
            return RegistriesList(registries: state.registries);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddRegistry(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
