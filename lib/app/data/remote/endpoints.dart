class Endpoints {
  static const createPartner = "/tida/v1/signup";
  static const loginCustomer = "/tida/v1/login";
  static const getUserId = "/tidasports/v1/getuseridbyemail";
  static const getUserDetails = "/wc/v3/customers";
  static const orders = "/tidasports/v1/getcustomerorders";
  static const forgotPassword = "/tidasports/v1/forgot_password";
  static const updatePassword = "/tidasports/v1/update_password";
  static const getAcademyBooking = "/tidasports/v1/getpartneracademyorders";
  static const getVenueBooking = "/tidasports/v1/getpartnervenueorders";
  static const getSubscriptionsBooking =
      "/tidasports/v1/getpartnersubscriptionorders";
  static const getProductsByPartner = "/tidasports/v1/getproductbypartner";
  static const getFCMToken = "/tida/v1/notification/find_fcm_token";
  static const updateFCMToken = "/tida/v1/notification/update_fcm_token";
  static const updateProfileImg = "/tida/v1/upload_profile_image";
  static const togglepayment = "/tida/v1/cod_payment_toggle";
  static const createOrder = "/wc/v3/orders";
  static const ordernotes = "/notes";
  static const sendBookingNotification = "/partner_notification";
  static const codoption = "/tida/v1/get_available_payment";
  static const getorderdetail = "/tidasports/v1/get_order_detail";
  static const getProfileImage = "/tida/v1/get_profile_image";
  static const upcomingBookings = "/tida/v1/get_upcoming_ordersbypartner";
  static const upcomingSubscriptions = "/tida/v1/get_upcoming_subscriptionsbypartner";
  static const updateOrderPayment = "/update_order_payment";
}
