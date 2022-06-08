import 'package:equatable/equatable.dart';

class Registry extends Equatable {
  final int? id;
  final String name;
  final DateTime? date;
  final String type;

  const Registry({
    this.id,
    required this.name,
    required this.date,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        date,
      ];

  @override
  String toString() => '''
  Registry {
    id: $id,
    name: $name,
    type: $type,
    date: $date,
  }''';

  factory Registry.empty() => const Registry(
        id: null,
        name: '',
        date: null,
        type: '',
      );
}

extension RegistryValidator on Registry {
  String? validateName() {
    if (name.isEmpty) {
      return 'O nome não pode ser vazio';
    }

    return null;
  }
}
