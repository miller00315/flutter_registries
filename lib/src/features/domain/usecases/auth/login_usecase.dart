import 'package:product_manager/src/features/domain/repositories/auth_repository_interface.dart';

abstract class LoginUsecaseInterface {
  Future call();
}

class LoginUsecaseImpl implements LoginUsecaseInterface {
  final AuthRepositoryBase repository;

  LoginUsecaseImpl(this.repository);

  @override
  Future call() async {
    return await repository.login();
  }
}
