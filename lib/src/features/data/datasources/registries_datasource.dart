import 'dart:async';

import 'package:dio/dio.dart';
import 'package:product_manager/src/features/data/models/registry_model.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';

abstract class RegistriesDataSourceBase {
  Stream<List<Registry>> startWatchRegistries();
  Future postRegistry(RegistryModel registry);
  Future<List<Registry>> getRegistries();
  Future stopWatchRegistries();
}

class RegistriesDataSourceImpl implements RegistriesDataSourceBase {
  final Dio dio;

  StreamController<List<RegistryModel>>? controller;

  RegistriesDataSourceImpl(this.dio);

  @override
  Future postRegistry(RegistryModel registry) async {
    try {
      final response = await dio.postUri(
        Uri.https(
          'jsonplaceholder.typicode.com',
          '/posts',
        ),
        data: registry.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );

      controller?.sink.add([RegistryModel.fromJson(response.data)]);
    } on DioError catch (error) {
      controller?.sink.addError(error);
    }
  }

  @override
  Stream<List<RegistryModel>> startWatchRegistries() {
    controller = StreamController<List<RegistryModel>>();

    return controller!.stream;
  }

  @override
  Future<List<RegistryModel>> getRegistries() async {
    final response = await dio.getUri(
      Uri.https(
        'my-json-server.typicode.com',
        '/miller00315/registries/db',
      ),
    );

    return (response.data['data'] as List)
        .map((json) => RegistryModel.fromJson(json))
        .toList();
  }

  @override
  Future stopWatchRegistries() async {
    await controller?.close();
  }
}
