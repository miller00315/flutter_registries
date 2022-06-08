import 'package:flutter/material.dart';

class AddRegistryForm extends StatelessWidget {
  const AddRegistryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(),
          TextFormField(
            keyboardType: TextInputType.datetime,
          ),
          TextFormField(),
        ],
      ),
    );
  }
}
