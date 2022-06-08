import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:product_manager/src/features/data/datasources/registries_datasource.dart';
import 'package:product_manager/src/features/data/models/registry_model.dart';
import 'package:product_manager/src/features/domain/entities/registry.dart';

import '../../../../test_resources/fake_entities.dart';

main() {
  final dio = Dio();

  String? getUri;

  String? postUri;

  final file = File('test/test_resources/fake_json.json').readAsStringSync();

  final json = jsonDecode(file);

  final dioAdapter = DioAdapter(dio: dio);

  final registriesDataSource = RegistriesDataSourceImpl(dio);

  final registryModel = fakeRegistryModels[0];

  group('RegistriesDatasource group =>', () {
    setUpAll(() {
      getUri = Uri.https(
        'my-json-server.typicode.com',
        '/miller00315/registries/db',
      ).toString();

      postUri = Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
      ).toString();
    });

    tearDownAll(() {
      registriesDataSource.stopWatchRegistries();
    });

    test('''GIVEN request a list of registry
    WHEN request success
    THEN should return a list of [RegistryModel]
    ''', () async {
      dioAdapter.onGet(
        getUri!,
        (server) => server.reply(200, json),
      );

      final res = await registriesDataSource.getRegistries();

      expect(
        res,
        (json['data'] as List).map((e) => RegistryModel.fromJson(e)).toList(),
      );
    });

    test('''GIVEN request a list of registry
    WHEN request fail
    THEN should thrown a error
    ''', () async {
      dioAdapter.onGet(
        getUri!,
        (server) => server.reply(404, {}),
      );

      try {
        await registriesDataSource.getRegistries();

        fail('method don\'t throw');
      } catch (e) {
        expect(e, isInstanceOf<DioError>());
      }
    });

    test('''GIVEN request create a registry
    WHEN request success
    THEN should return success and add result to a stream
    ''', () async {
      final stream = registriesDataSource.startWatchRegistries();

      final responseJson = registryModel.toJson();

      responseJson.addAll({'id': 1});

      dioAdapter.onPost(
        postUri!,
        (server) => server.reply(200, responseJson),
        data: registryModel.toJson(),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      try {
        await registriesDataSource.postRegistry(registryModel);
      } catch (e) {
        fail('shouldn\'t not throw');
      }

      stream.listen((event) {
        expect(event, [registryModel]);
      });

      registriesDataSource.stopWatchRegistries();
    });

    test('''GIVEN request create a registry
    WHEN request success
    THEN should add a error to a stream
    ''', () async {
      final stream = registriesDataSource.startWatchRegistries();

      final responseJson = registryModel.toJson();

      responseJson.addAll({'id': 1});

      dioAdapter.onPost(
        postUri!,
        (server) => server.reply(404, responseJson),
        data: registryModel.toJson(),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      try {
        await registriesDataSource.postRegistry(registryModel);
      } catch (e) {
        fail('shouldn\'t throw');
      }

      stream.listen((_) {
        fail('shouldn\'t listen nothing');
      }).onError((error) {
        expect(error, isInstanceOf<DioError>());
      });

      registriesDataSource.stopWatchRegistries();
    });
  });
}
