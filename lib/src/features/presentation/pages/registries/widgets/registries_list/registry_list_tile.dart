import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';

class RegistryListTile extends StatelessWidget {
  final Registry registry;

  const RegistryListTile({
    Key? key,
    required this.registry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(registry.name),
      subtitle: Column(
        children: [
          Text(DateFormat('dd/MM/yyyy').format(registry.date!)),
          Text(registry.type),
        ],
      ),
    );
  }
}
