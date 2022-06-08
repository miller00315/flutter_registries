import 'package:flutter/material.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';
import 'package:product_manager/src/features/presentation/pages/registries/widgets/registries_list/registry_list_tile.dart';

class RegistriesList extends StatelessWidget {
  final List<Registry> registries;

  const RegistriesList({
    Key? key,
    required this.registries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) => RegistryListTile(
        registry: registries[index],
      ),
      separatorBuilder: (context, _) => const SizedBox(
        height: 8,
      ),
      itemCount: registries.length,
    );
  }
}
