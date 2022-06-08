import 'package:product_manager/src/features/data/datasources/auth_datasource.dart';
import 'package:product_manager/src/features/domain/repositories/auth_repository_interface.dart';

class AuthRepositoryImpl implements AuthRepositoryBase {
  final AuthDataSourceBase authDataSourceBase;

  AuthRepositoryImpl(this.authDataSourceBase);

  @override
  Future geLoggedInUser() {
    // TODO: implement geLoggedInUser
    throw UnimplementedError();
  }

  @override
  Future login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future logoff() {
    // TODO: implement logoff
    throw UnimplementedError();
  }
}
