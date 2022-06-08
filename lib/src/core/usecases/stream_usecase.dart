import 'package:dartz/dartz.dart';
import 'package:product_manager/src/core/error/failures.dart';

abstract class StreamUsecase<Type, NoParams> {
  Stream<Either<Failure, Type>> call(NoParams params);
}
