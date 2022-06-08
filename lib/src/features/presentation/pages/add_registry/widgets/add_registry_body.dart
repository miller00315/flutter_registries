import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manager/src/core/status/request_status.dart';
import 'package:product_manager/src/features/presentation/bloc/add_registry_bloc/add_registry_bloc.dart';
import 'package:product_manager/src/features/presentation/pages/add_registry/widgets/add_registry_form.dart';

class AddRegistryBody extends StatelessWidget {
  const AddRegistryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddRegistryBloc, AddRegistryState>(
        builder: ((context, state) {
          if (state.status is InProgressStatus) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const SafeArea(
            child: AddRegistryForm(),
          );
        }),
      ),
    );
  }
}
