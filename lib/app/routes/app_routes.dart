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
  static const DETAILS_SCREEN = _Paths.DETAILS_SCREEN;
  static const ACADEMY_DETAILS = _Paths.ACADEMY_DETAILS;
  static const VENUE_DETAILS = _Paths.VENUE_DETAILS;
  static const ACADEMY_LISTING = _Paths.ACADEMY_LISTING;
  static const VENUE_LISTING = _Paths.VENUE_LISTING;
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
  static const DETAILS_SCREEN = "/details_screen";
  static const ACADEMY_DETAILS = "/academy_details";
  static const VENUE_DETAILS = "/venue_details";
  static const ACADEMY_LISTING = "/academy_listing";
  static const VENUE_LISTING = "/venue_listing";
  // static const SUBSCRIPTONS_ORDER_LISTING = "/subscriptions_order_listing"
}
