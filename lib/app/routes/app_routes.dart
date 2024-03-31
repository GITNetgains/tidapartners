part of 'app_pages.dart';

class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const SIGNIN = _Paths.SIGNIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const PROFILE = _Paths.PROFILE;
  static const ORDER_HISTORY = _Paths.ORDER_HISTORY;
  static const CHANGE_PASSWORD = _Paths.CHANGE_PASSWORD;
  static const HOME = _Paths.HOME;

}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const SIGNIN = '/signin';
  static const SIGNUP = '/signup';
  static const PROFILE = "/profile";
  static const ORDER_HISTORY = "/order_history";
  static const CHANGE_PASSWORD = "/change_password";
  static const HOME = "/home";
}
