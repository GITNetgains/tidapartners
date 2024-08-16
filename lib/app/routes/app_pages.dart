import 'package:get/get.dart';
import 'package:tidapartners/app/modules/academy/bindings/academy_details_bindings.dart';
import 'package:tidapartners/app/modules/academy/views/academy_details_view.dart';
import 'package:tidapartners/app/modules/academy/views/academy_list_view.dart';
import 'package:tidapartners/app/modules/details_screen/bindings/details_bindings.dart';
import 'package:tidapartners/app/modules/details_screen/views/details_view.dart';
import 'package:tidapartners/app/modules/past_bookings/bindings/past_bookings_bindings.dart';
import 'package:tidapartners/app/modules/upcoming_bookings/bindings/upcoming_bookings_bindings.dart';
import 'package:tidapartners/app/modules/upcoming_bookings/bindings/upcoming_details_bindings.dart';
import 'package:tidapartners/app/modules/upcoming_bookings/views/upcoming_bookings_view.dart';
import 'package:tidapartners/app/modules/upcoming_bookings/views/upcoming_details_view.dart';
import 'package:tidapartners/app/modules/venues/views/venue_details_view.dart';
import '../modules/academy/bindings/academy_list_binding.dart';
import '../modules/home/bindings/home_bindings.dart';
import '../modules/home/views/home_view.dart';
import '../modules/orders_listing/binding/orders_listing_binding.dart';
import '../modules/orders_listing/view/orders_listing_view.dart';
import '../modules/past_bookings/views/past_bookings_view.dart';
import '../modules/profile/bindings/change_password_binding.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/change_password_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_screen.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_screen.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/venues/bindings/venue_details_bindings.dart';
import '../modules/venues/bindings/venue_list_binding.dart';
import '../modules/venues/views/venue_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const SIGNIN = Routes.SIGNIN;
  static const SIGNUP = Routes.SIGNUP;
  static const SPLASH = Routes.SPLASH;
  static const PROFILE = Routes.PROFILE;
  static const ORDER_HISTORY = Routes.ORDER_HISTORY;
  static const CHANGE_PASSWORD = Routes.CHANGE_PASSWORD;
  static const DETAILS_SCREEN = Routes.DETAILS_SCREEN;
  static const HOME = Routes.HOME;
  static const ACADEMY_DETAILS = Routes.ACADEMY_DETAILS;
  static const VENUE_DETAILS = Routes.VENUE_DETAILS;
  static const VENUE_LISTING = Routes.VENUE_LISTING;
  static const ACADEMY_LISTING = Routes.ACADEMY_LISTING;
  static const ORDERS_LISTING = Routes.ORDERS_LISTING;
  static const UPCOMING_BOOKINGS = Routes.UPCOMING_BOOKINGS;
  static const PAST_BOOKINGS = Routes.PAST_BOOKINGS;
  static const UPCOMING_DETAILS_SCREEN = Routes.UPCOMING_DETAILS_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS_SCREEN,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.UPCOMING_DETAILS_SCREEN,
      page: () => const UpcomingDetailsView(),
      binding: UpcomingDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ACADEMY_DETAILS,
      page: () => const AcademyDetailsView(),
      binding: AcademyDetailsBinding(),
    ),
    GetPage(
      name: _Paths.VENUE_DETAILS,
      page: () => const VenueDetailsView(),
      binding: VenueDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ACADEMY_LISTING,
      page: () => const AcademyListView(),
      binding: AcademyListBinding(),
    ),
    GetPage(
      name: _Paths.VENUE_LISTING,
      page: () => const VenueListView(),
      binding: VenueListBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS_LISTING,
      page: () => const OrdersListingView(),
      binding: OrdersListingBinding(),
    ),
    GetPage(
      name: _Paths.UPCOMING_BOOKINGS,
      page: () => const UpcomingBookingsView(),
      binding: UpcomingBookingsBinding(),
    ),
    GetPage(
      name: _Paths.PAST_BOOKINGS,
      page: () => const PastBookingsView(),
      binding: PastBookingsBinding(),
    ),
  ];
}
