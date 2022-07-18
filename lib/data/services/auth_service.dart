import 'package:go_router_demo/dependency/service_locator.dart';

class AuthService {
  String _email = '';

  String _password = '';

  bool _onSignUpComplete = false;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  bool get isSignUpComplete => _onSignUpComplete;

  String get email => _email;

  String get password => _password;

  void init() async {
    _isLoggedIn = await preferencesSource().getIsLoggedIn();
  }

  void login(String email, String password) {
    _email = email;
    _password = password;
    preferencesSource().saveIsLoggedIn(true);
    _isLoggedIn = true;
  }

  void completeSignUp(String email, String password) {
    _email = email;
    _password = password;
    _onSignUpComplete = true;
    preferencesSource().saveIsLoggedIn(true);
    _isLoggedIn = true;
  }

  void logOut() {
    _email = '';
    _password = '';
    _onSignUpComplete = false;
    preferencesSource().clearIsLoggedIn();
    _isLoggedIn = false;
  }
}
