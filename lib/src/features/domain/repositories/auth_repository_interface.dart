abstract class AuthRepositoryBase {
  Future login();
  Future logoff();
  Future geLoggedInUser();
}
