import 'package:product_manager/src/features/domain/entities/registry.dart';

class RegistryModel extends Registry {
  const RegistryModel({
    required super.id,
    required super.name,
    required super.date,
    required super.type,
  });

  factory RegistryModel.fromJson(Map<String, dynamic> json) => RegistryModel(
        id: json['id'],
        name: json['name'],
        date: DateTime.parse(json['date']),
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'date': date?.toIso8601String() ?? '',
        'type': type,
      };

  factory RegistryModel.fromDomain(Registry registry) => RegistryModel(
        id: registry.id,
        date: registry.date,
        name: registry.name,
        type: registry.type,
      );
}
