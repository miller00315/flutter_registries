import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:product_manager/src/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}