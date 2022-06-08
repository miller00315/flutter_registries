abstract class AuthDataSourceBase {
  Future getLoggedInUser();
  Future login();
  Future logoff();
}

class AuthDataSourceImpl implements AuthDataSourceBase {
  @override
  Future getLoggedInUser() {
    // TODO: implement getLoggedInUser
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
