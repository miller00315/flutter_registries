// Mocks generated by Mockito 5.2.0 from annotations
// in product_manager/test/unit_tests/features/domain/usecases/post_registry_usecase/post_registry_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:product_manager/src/core/error/failures.dart' as _i5;
import 'package:product_manager/src/features/domain/entities/registry.dart'
    as _i7;
import 'package:product_manager/src/features/domain/repositories/registries_repository_interface.dart'
    as _i3;
import 'package:product_manager/src/features/domain/usecases/registries/post_registry_usecase.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [RegistriesRepositoryBase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegistriesRepositoryBase extends _i1.Mock
    implements _i3.RegistriesRepositoryBase {
  MockRegistriesRepositoryBase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> postRegistry(
          _i6.PostRegistryParams? params) =>
      (super.noSuchMethod(Invocation.method(#postRegistry, [params]),
              returnValue: Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
                  _FakeEither_0<_i5.Failure, _i2.Unit>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Stream<_i2.Either<_i5.Failure, List<_i7.Registry>>>
      startWatchRegistries() => (super.noSuchMethod(
              Invocation.method(#startWatchRegistries, []),
              returnValue:
                  Stream<_i2.Either<_i5.Failure, List<_i7.Registry>>>.empty())
          as _i4.Stream<_i2.Either<_i5.Failure, List<_i7.Registry>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> stopWatchRegistries() =>
      (super.noSuchMethod(Invocation.method(#stopWatchRegistries, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
                  _FakeEither_0<_i5.Failure, _i2.Unit>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.Registry>>> getRegistries() =>
      (super
              .noSuchMethod(Invocation.method(#getRegistries, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, List<_i7.Registry>>>.value(
                          _FakeEither_0<_i5.Failure, List<_i7.Registry>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i7.Registry>>>);
}
