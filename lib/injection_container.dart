import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:product_manager/src/features/data/datasources/auth_datasource.dart';
import 'package:product_manager/src/features/data/datasources/registries_datasource.dart';
import 'package:product_manager/src/features/data/repositories/auth_repository_impl.dart';
import 'package:product_manager/src/features/data/repositories/registries_repository_impl.dart';
import 'package:product_manager/src/features/domain/repositories/auth_repository_interface.dart';
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart';
import 'package:product_manager/src/features/domain/usecases/registries/get_registries_usecase.dart';
import 'package:product_manager/src/features/domain/usecases/registries/post_registry_usecase.dart';
import 'package:product_manager/src/features/domain/usecases/registries/stop_watch_registries_usecase.dart';
import 'package:product_manager/src/features/presentation/bloc/add_registry_bloc/add_registry_bloc.dart';
import 'package:product_manager/src/features/presentation/bloc/watch_registries_bloc/watch_registries_bloc.dart';

import 'src/features/domain/usecases/registries/start_watch_registries_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(
    () => Dio(),
  );

  serviceLocator.registerLazySingleton<RegistriesDataSourceBase>(
    () => RegistriesDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<RegistriesRepositoryBase>(
    () => RegistriesRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthDataSourceBase>(
    () => AuthDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<AuthRepositoryBase>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => GetRegistriesUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => StartWatchRegistriesUsecase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => StopWatchRegistriesUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => PostRegistryUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => WatchRegistriesBloc(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => AddRegistryBloc(
      serviceLocator(),
    ),
  );
}
